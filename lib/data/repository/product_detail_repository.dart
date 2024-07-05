import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/product_detail_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/data/model/product_image.dart';
import 'package:ecommerce_flutter_application/data/model/product_property.dart';
import 'package:ecommerce_flutter_application/data/model/product_variants.dart';
import 'package:ecommerce_flutter_application/data/model/variant_type.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductImage(String productId);

  Future<Either<String, List<VariantType>>> getVariantTypes();

  Future<Either<String, List<ProductVariants>>> getProductVariants(String productId);

  Future<Either<String, Category>> getProductCategory(String categoryId);

  Future<Either<String, List<Property>>> getProductProperties(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage(String productId) async {
    try {
      var response = await _dataSource.getGallery(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantTypes() async {
    try {
      var response = await _dataSource.getVariantTypes();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, List<ProductVariants>>> getProductVariants(String productId) async {
    try {
      var response = await _dataSource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _dataSource.getProductCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(String productId) async {
    try {
      var response = await _dataSource.getProductProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }
}
