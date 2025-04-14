import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/product/components/app_tooltip.widget.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/global/model/user_model.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:go_router/go_router.dart';

class ProfileFavouritesView extends StatelessWidget {
  ProfileFavouritesView({super.key});
  final toolKey = GlobalKey<State<Tooltip>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
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
                  "Favourites",
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
                  tooltipMessage: "Your favourites!",
                ),
              ],
            ),
            SizedBox(
              height: 0.024.sh,
            ),
            Expanded(
                child: productList
                        .where((p) => user.favouriteProducts.contains(p.id))
                        .toList()
                        .isEmpty
                    ? Center(
                        child: Text(
                          "You don't have any favorites yet.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: ResponsiveFontSize.optimusPrime(18),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: productList
                            .where((p) => user.favouriteProducts.contains(p.id))
                            .toList()
                            .length,
                        itemBuilder: (context, index) {
                          final favouriteList = productList
                              .where(
                                  (p) => user.favouriteProducts.contains(p.id))
                              .toList();

                          return GestureDetector(
                            onTap: () {
                              context.push('/product_detail', extra: {
                                'productId': favouriteList[index].id,
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
                                      favouriteList[index].image!,
                                      height: 0.12.sh,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.016.sw,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.01.sh,
                                          horizontal: 0.024.sw),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favouriteList[index].title!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ResponsiveFontSize
                                                  .optimusPrime(18),
                                            ),
                                          ),
                                          Text(
                                            favouriteList[index].description!,
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: ResponsiveFontSize
                                                  .optimusPrime(16),
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 0.006.sh,
                                          ),
                                          Text(
                                            '${favouriteList[index].price} ${String.fromCharCode(36)}',
                                            style: TextStyle(
                                              color:
                                                  ColorConstants.primaryGreen,
                                              fontSize: ResponsiveFontSize
                                                  .optimusPrime(20),
                                              fontWeight: FontWeight.w600,
                                            ),
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
                      )),
          ],
        ),
      ),
    );
  }
}
