import 'package:bloc/bloc.dart';
import 'package:ecommerce_flutter_application/bloc/product/product_event.dart';
import 'package:ecommerce_flutter_application/bloc/product/product_state.dart';
import 'package:ecommerce_flutter_application/data/model/basket_item.dart';
import 'package:ecommerce_flutter_application/data/repository/basket_repository.dart';
import 'package:ecommerce_flutter_application/data/repository/product_detail_repository.dart';
import 'package:ecommerce_flutter_application/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      var productImages = await _productRepository.getProductImage(event.productId);
      var productVariant = await _productRepository.getProductVariants(event.productId);
      var productCategory = await _productRepository.getProductCategory(event.categoryId);
      var productProperty = await _productRepository.getProductProperties(event.productId);
      emit(ProductDetailResponseState(productImages, productVariant, productCategory, productProperty));
    });
    on<ProductAddToBasket>((event, emit) async {
      var basketItem = BasketItem(
        event.product.id,
        event.product.collectionId,
        event.product.thumbnail,
        event.product.discountPrice,
        event.product.price,
        event.product.name,
        event.product.categoryId,
      );
      _basketRepository.addProductToBasket(basketItem);
    });
  }
}
