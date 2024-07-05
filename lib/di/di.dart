import 'package:dio/dio.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_bloc.dart';
import 'package:ecommerce_flutter_application/data/datasource/authentication_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/banner_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/basket_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/category_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/category_product_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/comment_datasource.dart';
import 'package:ecommerce_flutter_application/data/datasource/product_datasource.dart';
import 'package:ecommerce_flutter_application/data/repository/authentication_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/banner_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/basket_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/category_product_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/category_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/comment_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/product_detail_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/product_repository.dart';
import 'package:ecommerce_flutter_application/util/dio_provider.dart';
import 'package:ecommerce_flutter_application/util/payment_handler.dart';
import 'package:ecommerce_flutter_application/util/url_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarinpal/zarinpal.dart';

import '../data/datasource/product_detail_datasource.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  // Components & Utils
  await _initComponents();

  // Datasource's
  _initDataSource();

  //Repositories
  _initRepositories();

  // Bloc
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

void _initRepositories() {
  // It is better to make them all singleton
  locator.registerSingleton<IAuthRepository>(AuthenticationRepository());
  locator.registerSingleton<ICategoryRepository>(CategoryRepository());
  locator.registerSingleton<IBannerRepository>(BannerRepository());
  locator.registerSingleton<IProductRepository>(ProductRepository());
  locator
      .registerSingleton<IProductDetailRepository>(ProductDetailRepository());
  locator.registerSingleton<ICategoryProductRepository>(
      CategoryProductRepository());
  locator.registerSingleton<IBasketRepository>(BasketRepository());
  locator.registerSingleton<ICommentRepository>(CommentRepository());
}

void _initDataSource() {
  // Remote Datasource's:
  // locator.registerFactory<IProductDataSource>(() => ProductRemoteDatasource());
  // It is better to make them all singleton
  locator.registerSingleton<IAuthDatasource>(AuthenticationRemote());
  locator.registerSingleton<ICategoryDataSource>(CategoryRemoteDatasource());
  locator.registerSingleton<IBannerDataSource>(BannerRemoteDatasource());
  locator.registerSingleton<IProductDataSource>(ProductRemoteDatasource());
  locator.registerSingleton<IProductDetailDataSource>(
      ProductDetailRemoteDataSource());
  locator.registerSingleton<ICategoryProductDataSource>(
      CategoryProductRemoteDatasource());
  locator.registerSingleton<ICommentDataSource>(CommentRemoteDataSource());

  // Local Datasource's:
  locator.registerSingleton<IBasketDataSource>(BasketLocalDatasource());
}

Future<void> _initComponents() async {
  // Components
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(DioProvider.createDio());

  // utils
  locator.registerSingleton<UrlHandler>(UrlLauncher());
  locator.registerSingleton<PaymentRequest>(PaymentRequest());
  locator
      .registerSingleton<PaymentHandler>(ZarinPalPaymentHandler(locator.get()));
}
