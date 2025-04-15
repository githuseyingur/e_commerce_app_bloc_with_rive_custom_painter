import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/profile/widget/profile_container_widget.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: ColorConstants.primaryGreen,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(20.w),
              child: Icon(
                Icons.person_outline_sharp,
                size: ResponsiveFontSize.optimusPrime(72),
                color: ColorConstants.primaryBackground,
              ),
            ),
            SizedBox(
              height: 0.016.sh,
            ),
            Text(
              "Huseyin Gur",
              style: TextStyle(
                color: Colors.white70,
                fontSize: ResponsiveFontSize.optimusPrime(26),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 0.04.sh,
            ),
            BlocBuilder<RootPageCubit, RootPageState>(
              builder: (context, state) {
                return ProfileContainerWidget(
                  type: 0,
                  iconData: Icons.favorite,
                  onTap: () {
                    context.push('/profile_favourites',
                        extra: {'cubit': context.read<RootPageCubit>()});
                  },
                  title: 'Favourites',
                  count: state.favouriteProducts.length.toString(),
                );
              },
            ),
            BlocBuilder<RootPageCubit, RootPageState>(
              builder: (context, state) {
                return ProfileContainerWidget(
                  type: 1,
                  iconData: Icons.shopping_cart,
                  onTap: () {
                    context.push('/profile_cart',
                        extra: {'cubit': context.read<RootPageCubit>()});
                  },
                  title: 'Cart',
                  count: state.productListInCart.length.toString(),
                );
              },
            ),
            ProfileContainerWidget(
              type: 2,
              iconData: Icons.settings,
              onTap: () {},
              title: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
