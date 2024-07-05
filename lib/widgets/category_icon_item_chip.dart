import 'package:ecommerce_flutter_application/bloc/categoryProduct/category_product_bloc.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/screens/product_list_screen.dart';
import 'package:ecommerce_flutter_application/util/extentions/string_extensions.dart';
import 'package:ecommerce_flutter_application/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;

  const CategoryItemChip(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CategoryProductBloc(),
              child: ProductListScreen(category),
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: category.color!.parseToColor(),
                  shadows: [
                    BoxShadow(
                        color: category.color!.parseToColor(),
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: const Offset(0.0, 15))
                  ],
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: CachedImage(
                      imageUrl: category.icon,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            category.title ?? "محصولات",
            style: const TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
