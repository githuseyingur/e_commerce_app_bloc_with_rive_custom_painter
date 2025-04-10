import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.themeColor,
  });

  final void Function() onPressed;
  final String title;
  final ButtonThemeColors themeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.05.sh,
      width: 0.5.sw,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: themeColor == ButtonThemeColors.green
              ? ColorConstants.primaryGreen
              : themeColor == ButtonThemeColors.yellow
                  ? const Color(0xFFFFCE52)
                  : themeColor == ButtonThemeColors.blue
                      ? const Color.fromARGB(255, 67, 157, 213)
                      : themeColor == ButtonThemeColors.red
                          ? const Color.fromARGB(255, 207, 53, 73)
                          : const Color.fromARGB(255, 87, 90, 81),
          padding: const EdgeInsets.symmetric(horizontal: 0),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: themeColor == ButtonThemeColors.green ||
                    themeColor == ButtonThemeColors.yellow
                ? ColorConstants.textBlack
                : themeColor == ButtonThemeColors.blue
                    ? Colors.white
                    : themeColor == ButtonThemeColors.red
                        ? const Color.fromARGB(255, 198, 84, 99)
                        : const Color(0xFFE3F4FF),
            fontSize: ResponsiveFontSize.optimusPrime(22),
            letterSpacing: 0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

enum ButtonThemeColors { green, yellow, blue, red, gray }
