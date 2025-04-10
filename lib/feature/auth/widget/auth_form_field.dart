import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class AuthFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? labelText;
  final Color? labelColor;
  final Color? textColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final String obscuringCharacter;
  final String? hintText;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final int? maxLength;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final FocusNode? focusNode;
  final Color? hintColor;

  const AuthFormField({
    super.key,
    this.validator,
    required this.controller,
    this.labelText,
    this.labelColor,
    this.textColor,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.hintText,
    this.keyboardType,
    this.height,
    this.width,
    this.maxLength,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.inputFormatters,
    this.enabled,
    this.focusNode,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ResponsiveFontSize.optimusPrime(20),
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),
        cursorColor: ColorConstants.primaryGreen,
        cursorHeight: 0.022.sh,
        cursorWidth: 0.003.sw,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 208, 114, 107), width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorConstants.primaryGreen, width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorConstants.primaryGreen, width: 1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: ResponsiveFontSize.optimusPrime(16),
            fontWeight: FontWeight.w300,
            color: Colors.white60,
          ),
          labelStyle: TextStyle(
              fontSize: ResponsiveFontSize.optimusPrime(12),
              fontWeight: FontWeight.w300),
          errorStyle: TextStyle(
              color: const Color.fromARGB(255, 251, 143, 135),
              fontSize: ResponsiveFontSize.optimusPrime(12)),
        ),
        textInputAction: TextInputAction.done,
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          return null;
        },
        onChanged: onChanged,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        enabled: enabled,
      ),
    );
  }
}
