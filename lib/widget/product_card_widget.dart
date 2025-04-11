import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.onTap,
    required this.favouriteOnTap,
    required this.product,
    required this.favouriteColor,
  });
  final void Function() onTap;
  final void Function()? favouriteOnTap;
  final ProductModel product;
  final Color favouriteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.image!,
                    height: 0.2.sh,
                  ),
                ),
              ),
              Positioned(
                right: 6.w,
                top: 6.w,
                child: GestureDetector(
                  onTap: favouriteOnTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(24),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      Icons.favorite,
                      color: favouriteColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              product.title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveFontSize.optimusPrime(16),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 0.006.sh,
          ),
          Text(
            "${product.price} ${String.fromCharCode(36)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveFontSize.optimusPrime(20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
