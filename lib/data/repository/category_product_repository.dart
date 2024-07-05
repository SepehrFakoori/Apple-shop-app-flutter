import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/category_product_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId);
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId) async {
    try {
      var response = await _dataSource.getProductByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }
}
