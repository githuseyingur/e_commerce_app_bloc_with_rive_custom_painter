import 'package:flutter/material.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

SnackBar getSnackBar(
    {required String text, required SnackBarType snackBarType}) {
  return SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(
      text,
      style: TextStyle(
        color: snackBarType == SnackBarType.light ? Colors.black : Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: ResponsiveFontSize.optimusPrime(18),
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: snackBarType == SnackBarType.light
        ? const Color.fromARGB(255, 185, 216, 97)
        : const Color.fromARGB(255, 47, 47, 44),
  );
}

enum SnackBarType { dark, light }
