import 'package:flutter/material.dart';

class SliderImageWidget extends StatelessWidget {
  const SliderImageWidget({
    super.key,
    required this.sliderImage,
    required this.onTap,
  });
  final Image sliderImage;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: sliderImage,
      ),
    );
  }
}
