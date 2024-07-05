import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/datasource/basket_datasource.dart';
import 'package:ecommerce_flutter_application/data/model/basket_item.dart';
import 'package:ecommerce_flutter_application/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);

  Future<Either<String, List<BasketItem>>> getAllBasketItems();

  Future<int> getBasketFinalPrice();

  Future<void> removeProduct(int index);
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
      BasketItem basketItem) async {
    try {
      _dataSource.addProduct(basketItem);
      return right("محصول به سبد خرید اضافه شد.");
    } catch (ex) {
      return left("خطا در افزودن محصول به سبد خرید!");
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItems() async {
    try {
      var basketItemList = await _dataSource.getAllBasketItems();
      return right(basketItemList);
    } catch (ex) {
      return left("خطا در نمایش محصولات!");
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _dataSource.getBasketFinalPrice();
  }

  @override
  Future<void> removeProduct(int index) async {
    _dataSource.removeProduct(index);
  }
}
