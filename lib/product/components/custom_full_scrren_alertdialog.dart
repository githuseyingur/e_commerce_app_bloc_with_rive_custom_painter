import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class CustomFullScreenAlertDialog extends StatelessWidget {
  final Color alertBackgroundColor;
  final Color alertTitleTextColor;
  final double alertTitleTextFontSize;
  final Color alertTitleTextBackgroundColor;
  final Widget? widget;
  final Function()? onTap;
  final String title;
  final Function()? backOnTap;

  const CustomFullScreenAlertDialog({
    super.key,
    required this.alertBackgroundColor,
    required this.alertTitleTextColor,
    required this.alertTitleTextFontSize,
    required this.alertTitleTextBackgroundColor,
    this.widget,
    this.onTap,
    required this.title,
    required this.backOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        backgroundColor: alertBackgroundColor,
        content: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.001.sh,
                  color: ColorConstants.textBlack.withAlpha(120),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 1.sw,
                  height: 0.06.sh,
                  color: ColorConstants.textBlack,
                  padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: backOnTap,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: ResponsiveFontSize.optimusPrime(30),
                          color: ColorConstants.textBlack,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: ResponsiveFontSize.optimusPrime(24),
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: ResponsiveFontSize.optimusPrime(30),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.sw,
                  height: 0.008.sh,
                  color: ColorConstants.primaryGreen,
                ),
                Container(
                  width: 1.sw,
                  height: 0.001.sh,
                  color: ColorConstants.textBlack,
                ),
                widget ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
