import 'package:dartz/dartz.dart';
import 'package:ecommerce_flutter_application/data/model/basket_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemList;
  int basketFinalPrice;

  BasketDataFetchedState(this.basketItemList, this.basketFinalPrice);
}
