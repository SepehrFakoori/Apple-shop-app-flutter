import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/data/model/product_image.dart';
import 'package:ecommerce_flutter_application/data/model/product_property.dart';
import 'package:ecommerce_flutter_application/data/model/product_variants.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductDetailLoadingState extends ProductState {}

class ProductDetailResponseState extends ProductState {
  Either<String, List<ProductImage>> productImages;
  Either<String, List<ProductVariants>> productVariant;
  Either<String, Category> productCategory;
  Either<String, List<Property>> productProperty;

  ProductDetailResponseState(this.productImages, this.productVariant, this.productCategory, this.productProperty);
}
