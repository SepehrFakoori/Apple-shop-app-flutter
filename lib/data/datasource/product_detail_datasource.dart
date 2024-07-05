import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/data/model/product_image.dart';
import 'package:ecommerce_flutter_application/data/model/product_property.dart';
import 'package:ecommerce_flutter_application/data/model/product_variants.dart';
import 'package:ecommerce_flutter_application/data/model/variant.dart';
import 'package:ecommerce_flutter_application/data/model/variant_type.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery(String productId);

  Future<List<VariantType>> getVariantTypes();

  Future<List<Variant>> getVariants(String productId);

  Future<List<ProductVariants>> getProductVariants(String productId);

  Future<Category> getProductCategory(String categoryId);

  Future<List<Property>> getProductProperties(String productId);
}

class ProductDetailRemoteDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {
        "filter": 'product_id="$productId"',
      };

      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParams);

      return response.data["items"]
          .map<ProductImage>(
              (jsonObject) => ProductImage.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');

      return response.data["items"]
          .map<VariantType>((jsonObject) => VariantType.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Variant>> getVariants(String productId) async {
    try {
      Map<String, String> qParams = {
        "filter": 'product_id="$productId"',
      };
      var response = await _dio.get(
        'collections/variants/records',
        queryParameters: qParams,
      );

      return response.data["items"]
          .map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<ProductVariants>> getProductVariants(String productId) async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants(productId);

    List<ProductVariants> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var theVariantList = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(ProductVariants(variantType, theVariantList));
      }
      return productVariantList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {
        "filter": 'id="$categoryId"',
      };
      var response = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );

      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }

  @override
  Future<List<Property>> getProductProperties(String productId) async {
    try {
      Map<String, String> qParams = {
        "filter": 'product_id="$productId"',
      };
      var response = await _dio.get(
        'collections/properties/records',
        queryParameters: qParams,
      );

      return response.data['items']
          .map<Property>((jsonObject) => Property.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, "Unknown Error!");
    }
  }
}
