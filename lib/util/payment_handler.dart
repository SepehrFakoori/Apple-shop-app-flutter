import 'package:ecommerce_flutter_application/util/extentions/string_extensions.dart';
import 'package:ecommerce_flutter_application/util/url_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_links2/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest(int finalPrice);

  Future<void> sendPaymentRequest();

  Future<void> verifyPaymentRequest();
}

class ZarinPalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  UrlHandler urlHandler;
  String? _authority;
  String? _status;

  ZarinPalPaymentHandler(this.urlHandler);

  @override
  Future<void> initPaymentRequest(int finalPrice) async {
    // for test Payment use "_paymentRequest.setIsSandBox(true); if we use false it's real Payment with bank!"
    _paymentRequest.setIsSandBox(false);
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription("This for Apple Shop application Test!");
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    // _paymentRequest.setCallbackURL("scheme://host");
    _paymentRequest.setCallbackURL("expertflutter://shop");

    linkStream.listen((deepLink) {
      if (deepLink!.toLowerCase().contains('authority')) {
        _authority = deepLink.extractValueFromQuery('Authority');
        _status = deepLink.extractValueFromQuery('Status');
        verifyPaymentRequest();
      }
    });
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(_status!, _authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        debugPrint(refID);
      } else {
        debugPrint("Error!");
      }
    });
  }
}
