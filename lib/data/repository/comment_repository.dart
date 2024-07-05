import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/comment_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/comment.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);

  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _dataSource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, String>> postComment(String productId, String comment) async {
    try {
      await _dataSource.postComment(productId, comment);
      return right("نظر شما اضافه شد!");
    } on ApiException {
      return left("کامنت گذاری با مشکل مواجه شده است!");
    }
  }
}
