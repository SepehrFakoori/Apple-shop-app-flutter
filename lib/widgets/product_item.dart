import 'package:ecommerce_flutter_application/bloc/basket/basket_bloc.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:ecommerce_flutter_application/screens/product_detail_screen.dart';
import 'package:ecommerce_flutter_application/util/extentions/int_extensions.dart';
import 'package:ecommerce_flutter_application/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // Expanded(
                //   child: Container(),
                // ),
                // This is the better way than use expanded with expanded we get an error!
                const SizedBox(width: double.infinity),
                SizedBox(
                  width: 98,
                  height: 98,
                  child: CachedImage(
                    imageUrl: product.thumbnail,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset("assets/images/active_fav_product.png"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      child: Text(
                        "${product.percent!.round() ?? "0"} %",
                        style: const TextStyle(
                          fontFamily: "Shabnam",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                  child: Text(
                    product.name!,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: "Shabnam",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Container(
                  height: 53,
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue,
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "تومان",
                          style: TextStyle(
                            fontFamily: "Shabnam",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.price.convertToPrice(),
                              style: const TextStyle(
                                fontFamily: "Shabnam",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              product.finalPrice.convertToPrice(),
                              style: const TextStyle(
                                fontFamily: "Shabnam",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 24,
                          child: Image.asset(
                              "assets/images/icon_right_arrow_cricle.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
