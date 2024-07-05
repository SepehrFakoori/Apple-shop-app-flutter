import 'package:ecommerce_flutter_application/bloc/home/home_bloc.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_event.dart';
import 'package:ecommerce_flutter_application/bloc/home/home_state.dart';
import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/banner.dart';
import 'package:ecommerce_flutter_application/data/model/category.dart';
import 'package:ecommerce_flutter_application/data/model/product.dart';
import 'package:ecommerce_flutter_application/widgets/banner_slider.dart';
import 'package:ecommerce_flutter_application/widgets/category_icon_item_chip.dart';
import 'package:ecommerce_flutter_application/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _getHomeScreenContent(state, context);
          },
        ),
      ),
    );
  }
}

Widget _getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return const Center(
      child: LoadingAnimation(),
    );
  } else if (state is HomeRequestSuccessState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(HomeGetInitializeData());
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(top: 24)),
          const _GetSearchBox(),
          state.bannerList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exceptionMessage),
            );
          }, (listBanners) {
            return _GetBanners(listBanners);
          }),
          const _GetCategoryListTitle(),
          state.categoryList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exceptionMessage),
            );
          }, (categoryList) {
            return _GetCategoryList(categoryList);
          }),
          const _GetBestSellerTitle(),
          state.bestSellerProductList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exceptionMessage),
            );
          }, (bestSellerProductList) {
            return _GetBestSellerProducts(bestSellerProductList);
          }),
          const _GetMostViewedTitle(),
          state.hottestProductList.fold((exceptionMessage) {
            return SliverToBoxAdapter(
              child: Text(exceptionMessage),
            );
          }, (hottestProductList) {
            return _GetMostViewedProducts(hottestProductList);
          }),
          const SliverPadding(padding: EdgeInsets.only(bottom: 24.0)),
        ],
      ),
    );
  } else {
    return const Center(
      child: Text(
        "خطا در دریافت اطلاعات",
        style: TextStyle(
            fontFamily: "Shabnam",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.red),
      ),
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      width: 60,
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [AppColors.blue],
          strokeWidth: 1,
        ),
      ),
    );
  }
}

class _GetMostViewedProducts extends StatelessWidget {
  final List<Product> bestProductList;

  const _GetMostViewedProducts(
    this.bestProductList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 216,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bestProductList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProductItem(bestProductList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetMostViewedTitle extends StatelessWidget {
  const _GetMostViewedTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20.0, top: 32.0),
        child: Row(
          children: [
            Text(
              "پر بازدید ترین ها",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: AppColors.grey,
              ),
            ),
            Spacer(),
            Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(
              CupertinoIcons.forward,
              size: 16.0,
              color: AppColors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class _GetBestSellerProducts extends StatelessWidget {
  final List<Product> bestSellerProductList;

  const _GetBestSellerProducts(
    this.bestSellerProductList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 216,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bestSellerProductList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ProductItem(bestSellerProductList[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetBestSellerTitle extends StatelessWidget {
  const _GetBestSellerTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20.0),
        child: Row(
          children: [
            Text(
              "پر فروش ترین ها",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: AppColors.grey,
              ),
            ),
            Spacer(),
            Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
            ),
            SizedBox(width: 10.0),
            Icon(
              CupertinoIcons.forward,
              size: 16.0,
              color: AppColors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class _GetCategoryList extends StatelessWidget {
  final List<Category> listCategory;

  const _GetCategoryList(this.listCategory);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listCategory.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CategoryItemChip(listCategory[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GetCategoryListTitle extends StatelessWidget {
  const _GetCategoryListTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(left: 44.0, right: 44.0, bottom: 20.0, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "دسته بندی",
              style: TextStyle(
                fontFamily: "Shabnam",
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GetBanners extends StatelessWidget {
  final List<BannerCampaign> bannerCampain;

  const _GetBanners(this.bannerCampain);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerCampain),
    );
  }
}

class _GetSearchBox extends StatelessWidget {
  const _GetSearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
              Image.asset("assets/images/icon_search.png"),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  "جستجوی محصولات",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Shabnam",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
              ),
              Image.asset("assets/images/icon_apple_blue.png"),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
