import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/product_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/util/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();

  Future<Either<String, List<Product>>> getHottest();

  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _datasource.getBestSeller();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }

  @override
  Future<Either<String, List<Product>>> getHottest() async {
    try {
      var response = await _datasource.getHottest();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? "Text Error we got!");
    }
  }
}
