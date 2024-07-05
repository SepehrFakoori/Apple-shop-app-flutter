import 'package:bloc/bloc.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_event.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_state.dart';
import 'package:ecommerce_flutter_application/data/repository/basket_repository.dart';
import 'package:ecommerce_flutter_application/util/payment_handler.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository;
  final PaymentHandler _paymentHandler;

  BasketBloc(this._paymentHandler, this._basketRepository) : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItems();
      var basketFinalPrice = await _basketRepository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemList, basketFinalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      var basketFinalPrice = await _basketRepository.getBasketFinalPrice();
      _paymentHandler.initPaymentRequest(basketFinalPrice);
    });

    on<BasketPaymentRequestEvent>((event, emit) async {
      _paymentHandler.sendPaymentRequest();
    });

    on<BasketRemoveProductEvent>((event, emit) async {
      _basketRepository.removeProduct(event.index);
      var basketItemList = await _basketRepository.getAllBasketItems();
      var basketFinalPrice = await _basketRepository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemList, basketFinalPrice));
    });
  }
}
