import 'package:bloc/bloc.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_event.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_state.dart';
import 'package:ecommerce_flutter_application/data/repository/banner_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/category_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/product_repository.dart';
import 'package:ecommerce_flutter_application/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitializeData>((event, emit) async {
      emit(HomeLoadingState());

      var bannerList = await _bannerRepository.getBanners();
      var categoryList = await _categoryRepository.getCategories();
      var productList = await _productRepository.getProducts();
      var hottestProductList = await _productRepository.getHottest();
      var bestSellerProductList = await _productRepository.getBestSeller();

      emit(
        HomeRequestSuccessState(
          bannerList,
          categoryList,
          productList,
          hottestProductList,
          bestSellerProductList,
        ),
      );

      // var hottestProductList = await _productRepository.getHottest();
      // emit(HomeRequestHottestState(hottestProductList));
      //
      // var bestSellerProductList = await _productRepository.getBestSeller();
      // emit(HomeRequestBestSellerState(bestSellerProductList));
    });
  }
}
