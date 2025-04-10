import 'package:flutter/material.dart';

class ResponsiveFontSize {
  static double optimusPrime(double fontSize) {
    // Reference Screen Sizes
    double referenceWidth = 411.0;
    double referenceHeight = 890.0;

    // Current Screen Sizes
    double deviceWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    double deviceHeight = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    // Screen Ratios
    double widthRatio = deviceWidth / referenceWidth;
    double heightRatio = deviceHeight / referenceHeight;

    // Optimization
    if (widthRatio < 0.88) widthRatio *= 0.86;
    if (heightRatio < 0.88) heightRatio *= 0.86;

    if (widthRatio > 1.2) widthRatio = widthRatio * 0.86;
    if (heightRatio > 1.2) heightRatio = heightRatio * 0.86;

    return (fontSize * ((widthRatio + heightRatio) / 2));
  }
}
