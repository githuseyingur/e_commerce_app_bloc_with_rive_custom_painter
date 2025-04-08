import 'package:flutter/material.dart';
import 'package:flutter_ui/model/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.onTap,
    required this.favouriteOnTap,
    required this.product,
    required this.favouriteColor,
  });
  final void Function() onTap;
  final void Function() favouriteOnTap;
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: AssetImage(product.imagePath),
                    )),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black.withAlpha(24),
                  child: GestureDetector(
                    onTap: favouriteOnTap,
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
              product.name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "${product.price}₺",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
