import 'package:ecommerce_flutter_application/bloc/category/category_bloc.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      const Expanded(
                        child: Text(
                          "دسته بندی",
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
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: ((context, state) {
                if (state is CategoryLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is CategoryResponseState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return _ListCategory(list: r);
                  });
                }
                return const SliverToBoxAdapter(child: Text("Error!"));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCategory extends StatelessWidget {
  final List<Category>? list;

  const _ListCategory({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CachedImage(imageUrl: list?[index].thumbnail);
          },
          childCount: list?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
