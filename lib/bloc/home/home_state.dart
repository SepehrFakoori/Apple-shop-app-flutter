import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/model/banner.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerCampaign>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hottestProductList;
  Either<String, List<Product>> bestSellerProductList;

  HomeRequestSuccessState(
    this.bannerList,
    this.categoryList,
    this.productList,
    this.hottestProductList,
    this.bestSellerProductList,
  );
}

// class HomeRequestHottestState extends HomeState {
//   Either<String, List<Product>> hottestProductList;
//
//   HomeRequestHottestState(this.hottestProductList);
// }
//
// class HomeRequestBestSellerState extends HomeState {
//   Either<String, List<Product>> bestSellerProductList;
//
//   HomeRequestBestSellerState(this.bestSellerProductList);
// }
