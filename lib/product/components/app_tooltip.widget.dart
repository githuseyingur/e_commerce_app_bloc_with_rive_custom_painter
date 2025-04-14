import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class AppTooltipWidget extends StatelessWidget {
  const AppTooltipWidget({
    super.key,
    required this.toolKey,
    required this.onTap,
    required this.tooltipMessage,
  });

  final GlobalKey<State<Tooltip>> toolKey;
  final Function() onTap;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: toolKey,
      richMessage: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: tooltipMessage,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: ResponsiveFontSize.optimusPrime(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
      padding: EdgeInsets.symmetric(horizontal: 0.028.sw, vertical: 0.016.sh),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 160, 160, 160),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: ResponsiveFontSize.optimusPrime(0.4),
          color: Colors.white12,
        ),
      ),
      textAlign: TextAlign.center,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.info_outline,
          size: ResponsiveFontSize.optimusPrime(24),
          color: Colors.white70,
        ),
      ),
    );
  }
}
