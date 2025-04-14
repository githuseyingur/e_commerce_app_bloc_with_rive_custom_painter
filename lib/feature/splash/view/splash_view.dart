import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_state.dart';
import 'package:flutter_ui/feature/splash/cubit/splash_cubit.dart';
import 'package:flutter_ui/feature/splash/cubit/splash_state.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:flutter_ui/product/helper/functions/get_snackbar.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              color: ColorConstants.primaryGreen,
              size: ResponsiveFontSize.optimusPrime(52),
            ),
            BlocListener<SplashCubit, SplashState>(
              listener: (context, state) {
                if (state.productState == ProductStates.completed) {
                  context.read<SplashCubit>().setProductStateToInitial();
                  context.pushReplacement("/login");
                }
              },
              child: SizedBox(
                height: 0.02.sh,
              ),
            ),
            Text(
              "E-commerce App",
              style: TextStyle(
                color: ColorConstants.primaryGreen,
                fontSize: ResponsiveFontSize.optimusPrime(26),
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
