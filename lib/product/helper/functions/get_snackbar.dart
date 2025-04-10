import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

SnackBar getSnackBar({required String text, required SnackbarEnum type}) {
  return SnackBar(
    backgroundColor: type == SnackbarEnum.info
        ? ColorConstants.textBlack
        : type == SnackbarEnum.error
            ? Colors.red
            : type == SnackbarEnum.warning
                ? const Color.fromARGB(255, 231, 153, 8)
                : const Color.fromARGB(255, 54, 141, 83),
    shape: Border(
      top: BorderSide(
        width: 0.6.h,
        color: Colors.green,
      ),
    ),
    duration: Duration(seconds: 3),
    content: Text(
      text,
      style: TextStyle(
        fontSize: ResponsiveFontSize.optimusPrime(15),
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

enum SnackbarEnum { info, success, error, warning }
