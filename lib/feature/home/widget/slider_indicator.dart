import 'package:flutter/material.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({super.key, required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          expansionFactor: 4,
          spacing: 12,
          dotWidth: 6,
          dotHeight: 6,
          activeDotColor: ColorConstants.primaryGreen,
          dotColor: Colors.white54,
        ),
        activeIndex: activeIndex,
        count: 4,
      ),
    );
  }
}
