import 'package:ecommerce_flutter_application/data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);

  Future<List<BasketItem>> getAllBasketItems();

  Future<int> getBasketFinalPrice();

  Future<void> removeProduct(int index);
}

class BasketLocalDatasource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('BasketBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (accumulator, product) => accumulator + product.finalPrice!);

    return finalPrice;
  }

  @override
  Future<void> removeProduct(int index) async{
    box.deleteAt(index);
  }
}
