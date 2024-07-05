import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/authentication_datasource.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository implements IAuthRepository {
  final IAuthDatasource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right("Sign up is done");
    } on ApiException catch (ex) {
      return left(ex.message ?? "Error isn't because of text!");
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return right("You have Sign in");
      } else {
        return left("There is an Error!");
      }
    } on ApiException catch (ex) {
      return left(ex.message ?? "Error isn't because of text!");
    }
  }
}
