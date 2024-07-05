import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_event.dart';
import 'package:ecommerce_flutter_application/bloc/basket/basket_state.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/basket_item.dart';
import 'package:ecommerce_flutter_application/util/extentions/int_extensions.dart';
import 'package:ecommerce_flutter_application/util/extentions/string_extensions.dart';
import 'package:ecommerce_flutter_application/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 44,
                          right: 44,
                          bottom: 32,
                        ),
                        child: Container(
                          height: 46.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Image.asset("assets/images/icon_apple_blue.png"),
                              const Expanded(
                                child: Text(
                                  "سبد خرید",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Shabnam",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is BasketDataFetchedState) ...{
                      state.basketItemList.fold((exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      }, (basketList) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return CardItem(basketList[index], index);
                            },
                            childCount: basketList.length,
                          ),
                        );
                      }),
                    },
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 64),
                    ),
                  ],
                ),
                if (state is BasketDataFetchedState) ...{
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 44.0,
                      right: 44.0,
                      bottom: 20.0,
                    ),
                    child: SizedBox(
                      width: MediaQuery
                          .sizeOf(context)
                          .width,
                      height: 53,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontFamily: "Shabnam",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentInitEvent());
                          context
                              .read<BasketBloc>()
                              .add(BasketPaymentRequestEvent());
                        },
                        child: (state.basketFinalPrice == 0)
                            ? const Text(
                            textAlign: TextAlign.right,
                            "سبد خرید شما خالی است!")
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "تومان",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Shabnam",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.basketFinalPrice.convertToPrice(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Shabnam",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "پرداخت",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Shabnam",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final BasketItem basketItem;
  final int index;

  const CardItem(this.basketItem, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249,
      margin: const EdgeInsets.only(right: 44.0, left: 44.0, bottom: 20.0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          basketItem.name!,
                          style: const TextStyle(
                            fontFamily: "Shabnam",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "گارانتی فلان فیسار 18 ماهه",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Shabnam",
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
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
                                  "%${basketItem.percent?.toInt()}",
                                  style: const TextStyle(
                                    fontFamily: "Shabnam",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "تومان",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Shabnam",
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              basketItem.price.convertToPrice(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Shabnam",
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<BasketBloc>().add(
                                    BasketRemoveProductEvent(index));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.red,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "حذف",
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Shabnam",
                                          fontSize: 12,
                                          color: AppColors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Image.asset(
                                          "assets/images/icon_trash.png"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const OptionCheap(
                              "آبی",
                              color: "4287f5",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                      height: 104,
                      width: 75,
                      child: CachedImage(
                        fit: BoxFit.contain,
                        imageUrl: basketItem.thumbnail,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashGapLength: 8.0,
              dashColor: AppColors.grey.withOpacity(0.5),
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "تومان",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Shabnam",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  basketItem.finalPrice.convertToPrice(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Shabnam",
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCheap extends StatelessWidget {
  final String? color;
  final String title;

  const OptionCheap(this.title, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.parseToColor(),
                ),
              ),
            },
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Shabnam",
                fontSize: 12,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
