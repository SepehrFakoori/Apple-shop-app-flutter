import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProducts();

  Future<List<Product>> getHottest();

  Future<List<Product>> getBestSeller();
}

class ProductRemoteDatasource extends IProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');

      return response.data["items"]
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    try {
      Map<String, String> qParams = {
        "filter": 'popularity="Best Seller"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data["items"]
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Product>> getHottest() async {
    try {
      Map<String, String> qParams = {
        "filter": 'popularity="Hotest"',
      };
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);

      return response.data["items"]
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }
}
