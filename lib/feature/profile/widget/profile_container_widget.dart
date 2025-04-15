import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class ProfileContainerWidget extends StatelessWidget {
  const ProfileContainerWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.iconData,
    this.count,
    required this.type,
  });
  final String title;
  final Function() onTap;
  final IconData iconData;
  final String? count;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.016.sh),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.032.sw),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.w,
                color: Colors.white70,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding:
                EdgeInsets.symmetric(vertical: 0.01.sh, horizontal: 0.04.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  iconData,
                  size: ResponsiveFontSize.optimusPrime(24),
                  color: Colors.white70,
                ),
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: ResponsiveFontSize.optimusPrime(20),
                      ),
                    ),
                    SizedBox(
                      width: 0.024.sw,
                    ),
                    count == null || count == '0'
                        ? const SizedBox()
                        : Container(
                            width: 0.054.sw,
                            height: 0.054.sw,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: type == 1
                                  ? const Color.fromARGB(255, 169, 196, 95)
                                  : Colors.white24,
                            ),
                            child: Text(
                              count!,
                              style: TextStyle(
                                color: type == 1 ? Colors.black : Colors.white,
                                fontSize: ResponsiveFontSize.optimusPrime(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: ResponsiveFontSize.optimusPrime(32),
                  color: Colors.white70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
