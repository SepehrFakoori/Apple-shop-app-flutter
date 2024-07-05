import 'package:ecommerce_flutter_application/bloc/categoryProduct/category_product_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/categoryProduct/category_product_event.dart';
import 'package:ecommerce_flutter_application/bloc/categoryProduct/category_product_state.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;

  const ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context).add(
      CategoryProductInitializeEvent(widget.category.id!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        body: SafeArea(
          child: CustomScrollView(
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
                        Expanded(
                          child: Text(
                            widget.category.title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
              if (state is CategoryProductLoadingState) ...{
                const SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              },
              if (state is CategoryProductResponseSuccessState) ...{
                state.productListByCategory.fold((exceptionMessage) {
                  return SliverToBoxAdapter(
                    child: Text(exceptionMessage),
                  );
                }, (productList) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 44.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ProductItem(productList[index]);
                      }, childCount: productList.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.8,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                    ),
                  );
                }),
              },
            ],
          ),
        ),
      );
    });
  }
}
