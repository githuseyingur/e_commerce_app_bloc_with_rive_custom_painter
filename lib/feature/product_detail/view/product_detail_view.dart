import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';
import 'package:flutter_ui/feature/unavailable/view/unavailable_view.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:go_router/go_router.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
      body: Padding(
        padding: EdgeInsets.all(0.04.sw),
        child: SingleChildScrollView(
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
                        productList.firstWhere((p) => p.id == productId).image!,
                        height: 0.2.sh,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.012.sh,
                    right: 0.012.sh,
                    child: BlocBuilder<RootPageCubit, RootPageState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<RootPageCubit>()
                                .setFavourite(productId);
                          },
                          child: Icon(
                            state.favouriteProducts.contains(productId)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: ResponsiveFontSize.optimusPrime(28),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Text(
                productList.firstWhere((p) => p.id == productId).title!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveFontSize.optimusPrime(22),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 0.004.sh,
              ),
              Text(
                productList.firstWhere((p) => p.id == productId).description!,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: ResponsiveFontSize.optimusPrime(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        productList
                            .firstWhere((p) => p.id == productId)
                            .rating!
                            .rate!
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveFontSize.optimusPrime(20),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 0.012.sw,
                      ),
                      for (int i = 0; i < 5; i++)
                        productList
                                    .firstWhere((p) => p.id == productId)
                                    .rating!
                                    .rate! >
                                i + 1
                            ? Icon(
                                Icons.star,
                                size: ResponsiveFontSize.optimusPrime(24),
                                color: ColorConstants.primaryGreen,
                              )
                            : productList
                                        .firstWhere((p) => p.id == productId)
                                        .rating!
                                        .rate!
                                        .ceil() ==
                                    i + 1
                                ? Icon(
                                    Icons.star_half,
                                    color: ColorConstants.primaryGreen,
                                    size: ResponsiveFontSize.optimusPrime(24),
                                  )
                                : Icon(
                                    Icons.star,
                                    color: Colors.white70,
                                    size: ResponsiveFontSize.optimusPrime(24),
                                  ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Text(
                        '${productList.firstWhere((p) => p.id == productId).rating!.count} ratings',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: ResponsiveFontSize.optimusPrime(16),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.4.w, color: Colors.white70),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.032.sw, vertical: 0.006.sh),
                    alignment: Alignment.center,
                    child: Text(
                      productList
                          .firstWhere((p) => p.id == productId)
                          .category!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: ResponsiveFontSize.optimusPrime(14),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.024.sh,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8.w,
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.02.sw,
                    vertical: 0.012.sh,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${productList.firstWhere((p) => p.id == productId).price!} ${String.fromCharCode(36)}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: ResponsiveFontSize.optimusPrime(24),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    SnackBar snackBar = SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        "Added",
                        style: TextStyle(
                          color: ColorConstants.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: ResponsiveFontSize.optimusPrime(18),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: const Color.fromARGB(255, 185, 216, 97),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: SizedBox(
                    width: 0.54.sw,
                    height: 0.1.sh,
                    child: CustomPaint(
                      painter: CustomShape(),
                      child: Center(
                        child: Text(
                          "Add to Chart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: ResponsiveFontSize.optimusPrime(18),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.01.sh,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: 0.4.sw,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryGreen,
                        borderRadius: BorderRadius.circular(99.r),
                        border: Border.all(
                          width: 1.2.w,
                          color: Colors.black26,
                        )),
                    padding: EdgeInsets.all(6.w),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: ResponsiveFontSize.optimusPrime(32),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rate_outlined,
                    color: Colors.white38,
                    size: ResponsiveFontSize.optimusPrime(22),
                  ),
                  SizedBox(
                    width: 0.01.sw,
                  ),
                  Text(
                    'Ratings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveFontSize.optimusPrime(20),
                    ),
                  ),
                  Text(
                    ' (${productList.firstWhere((p) => p.id == productId).rating!.count!})',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: ResponsiveFontSize.optimusPrime(18),
                    ),
                  ),
                  Text(
                    '    The section below is UI only – no API ',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: ResponsiveFontSize.optimusPrime(16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.006.sh,
              ),
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8.w, color: Colors.white38),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.024.sw, vertical: 0.012.sh),
                child: Column(
                  children: [
                    for (int i = 0; i < 2; i++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int j = 0; j < (i == 0 ? 4 : 3); j++)
                                Icon(
                                  Icons.star,
                                  size: ResponsiveFontSize.optimusPrime(20),
                                  color: ColorConstants.primaryGreen,
                                ),
                              for (int k = 0; k < (i == 0 ? 1 : 2); k++)
                                Icon(
                                  Icons.star,
                                  size: ResponsiveFontSize.optimusPrime(20),
                                  color: Colors.white70,
                                ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Text(
                                i == 0 ? "4.0" : "3.0",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: ResponsiveFontSize.optimusPrime(18),
                                ),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Text(
                                "-",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: ResponsiveFontSize.optimusPrime(20),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              Text(
                                i == 0
                                    ? "Huseyin Gur"
                                    : "Muhammed Izzet Hosgor",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: ResponsiveFontSize.optimusPrime(18),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 0.004.sh,
                          ),
                          Text(
                            i == 0
                                ? "The laptop bag is well-designed and offers great protection for my device. The material feels durable and the compartments are very practical for carrying accessories. The shoulder strap is comfortable and adjustable. I deducted one star because the zippers could be a bit smoother, but overall, it's a solid and reliable bag for everyday use."
                                : "Decent bag, but the quality isn't as good as I expected.",
                            style: TextStyle(
                              fontSize: ResponsiveFontSize.optimusPrime(16),
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 0.016.sh,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
