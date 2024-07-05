import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/data/model/comment.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';
import 'package:ecommerce_flutter_application/util/auth_manager.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComments(String productId);

  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDataSource extends ICommentDataSource {
  final Dio _dio = locator.get();
  final String userId = AuthManager.getId();

  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, dynamic> qParams = {
        "filter": 'product_id="$productId"',
        "expand": 'user_id',
        "perPage": 100,
      };

      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data["items"]
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      await _dio.post(
        'collections/comment/records',
        data: {
          'text': comment,
          'user_id': userId,
          'product_id': productId,
        },
      );
    } on DioException {
      return;
    } catch (ex) {
      return;
    }
  }
}
