import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';
import 'package:ecommerce_flutter_application/util/auth_manager.dart';
import 'package:ecommerce_flutter_application/util/dio_provider.dart';

abstract class IAuthDatasource {
  Future<void> register(
      String username, String password, String passwordConfirm);

  Future<String> login(String username, String password);
}

class AuthenticationRemote implements IAuthDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      var response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
          'name': username,
        },
      );
      if (response.statusCode == 200) {
        // AuthManager.saveId(response.data?['id']);
        login(username, password);
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode, ex.response?.statusMessage ?? "It's NULL!",
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        AuthManager.saveId(response.data?['record']['id']);
        AuthManager.saveToken(response.data?["token"]);
        return response.data?["token"];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode, ex.response?.statusMessage ?? "It's NULL!");
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
    return "";
  }
}
