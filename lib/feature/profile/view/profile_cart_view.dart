import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';
import 'package:flutter_ui/product/components/app_tooltip.widget.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:flutter_ui/product/helper/functions/get_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCartView extends StatelessWidget {
  ProfileCartView({super.key});
  final toolKey = GlobalKey<State<Tooltip>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
      bottomSheet: SizedBox(
        height: 0.16.sh,
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 0.12.sh,
              color: ColorConstants.primaryGreen,
              padding:
                  EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.01.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: ResponsiveFontSize.optimusPrime(20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 0.004.sh,
                      ),
                      BlocBuilder<RootPageCubit, RootPageState>(
                        builder: (context, state) {
                          double price = 0;
                          for (var element in state.productListInCart) {
                            price += productList
                                .firstWhere((p) => p.id == element)
                                .price!;
                          }
                          return Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.w, color: Colors.black54),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.032.sw, vertical: 0.008.sh),
                            child: Text(
                              "${price.toStringAsFixed(2)} ${String.fromCharCode(36)}",
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: ResponsiveFontSize.optimusPrime(24),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<RootPageCubit, RootPageState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          if (state.productListInCart.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              getSnackBar(
                                text:
                                    "Purchase failed: Your cart has no items.",
                                snackBarType: SnackBarType.dark,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 0.32.sw,
                          height: 0.054.sh,
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryBackground,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "BUY NOW",
                            style: TextStyle(
                              color: ColorConstants.primaryGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: ResponsiveFontSize.optimusPrime(16),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
              width: 1.sw,
              height: 0.04.sh,
              color: ColorConstants.primaryBackground,
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.024.sh),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                    size: ResponsiveFontSize.optimusPrime(30),
                  ),
                ),
                Text(
                  "Cart",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ResponsiveFontSize.optimusPrime(26),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppTooltipWidget(
                  toolKey: toolKey,
                  onTap: () {
                    final dynamic tooltip = toolKey.currentState;
                    tooltip?.ensureTooltipVisible();
                  },
                  tooltipMessage: "Cart",
                ),
              ],
            ),
            SizedBox(
              height: 0.024.sh,
            ),
            Expanded(child: BlocBuilder<RootPageCubit, RootPageState>(
              builder: (context, state) {
                if (productList
                    .where((p) => state.productListInCart.contains(p.id))
                    .toList()
                    .isEmpty) {
                  return Center(
                    child: Text(
                      "You don't have any products in your cart.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: ResponsiveFontSize.optimusPrime(18),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: productList
                        .where((p) => state.productListInCart.contains(p.id))
                        .toList()
                        .length,
                    itemBuilder: (context, index) {
                      final cartProductList = productList
                          .where((p) => state.productListInCart.contains(p.id))
                          .toList();

                      return GestureDetector(
                        onTap: () {
                          context.push('/product_detail', extra: {
                            'productId': cartProductList[index].id,
                            'cubit': context.read<RootPageCubit>(),
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 0.016.sh),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Colors.white54,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 0.24.sw,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: Image.network(
                                  cartProductList[index].image!,
                                  height: 0.14.sh,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.01.sh, horizontal: 0.032.sw),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartProductList[index].title!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFontSize.optimusPrime(
                                                  18),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0.002.sh,
                                      ),
                                      Text(
                                        cartProductList[index].description!,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize:
                                              ResponsiveFontSize.optimusPrime(
                                                  16),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 0.01.sh,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${cartProductList[index].price} ${String.fromCharCode(36)}',
                                            style: TextStyle(
                                              color:
                                                  ColorConstants.primaryGreen,
                                              fontSize: ResponsiveFontSize
                                                  .optimusPrime(22),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Row(
                                            spacing: 0.01.sw,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<RootPageCubit>()
                                                      .removeFromCart(
                                                          cartProductList[index]
                                                              .id!);
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.white54,
                                                  size: ResponsiveFontSize
                                                      .optimusPrime(24),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 0.6.w,
                                                    color: Colors.white70,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.024.sw,
                                                  vertical: 0.005.sh,
                                                ),
                                                child: Text(
                                                  '${state.productListInCart.where((p) => p == cartProductList[index].id).toList().length}',
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: ResponsiveFontSize
                                                        .optimusPrime(16),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<RootPageCubit>()
                                                      .addToCart(
                                                          cartProductList[index]
                                                              .id!);
                                                },
                                                child: Icon(
                                                  Icons.add_circle_rounded,
                                                  color: Colors.white54,
                                                  size: ResponsiveFontSize
                                                      .optimusPrime(24),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
