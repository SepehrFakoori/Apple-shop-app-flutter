import 'package:ecommerce_flutter_application/constants/colors.dart';
import 'package:ecommerce_flutter_application/data/model/banner.dart';
import 'package:ecommerce_flutter_application/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerCampaign> bannerList;

  const BannerSlider(this.bannerList, {super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: CachedImage(
                    radius: 15.0,
                    imageUrl: bannerList[index].thumbnail,
                  ));
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: SmoothPageIndicator(
            controller: controller,
            count: bannerList.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              dotColor: Colors.white,
              activeDotColor: AppColors.blueIndicator,
            ),
          ),
        ),
      ],
    );
  }
}
