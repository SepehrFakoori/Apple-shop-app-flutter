import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/util/auth_manager.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://startflutter.ir/api/',
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${AuthManager.readAuth()}"
        },
      ),
    );

    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/'),
    );

    return dio;
  }
}
