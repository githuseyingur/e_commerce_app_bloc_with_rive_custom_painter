import 'package:flutter/material.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget(
      {super.key, required this.isSelected, required this.title});

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 16),
        width: 140,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            color:
                isSelected ? const Color(0xFFD7FC70) : const Color(0xFF2B2B2B)),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: ResponsiveFontSize.optimusPrime(16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
