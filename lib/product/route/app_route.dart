import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_ui/feature/auth/view/login_view.dart';
import 'package:flutter_ui/feature/auth/view/register_view.dart';
import 'package:flutter_ui/feature/product_detail/view/product_detail_view.dart';
import 'package:flutter_ui/feature/profile/view/profile_favourites_view.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_cubit.dart';
import 'package:flutter_ui/feature/splash/cubit/splash_cubit.dart';
import 'package:flutter_ui/feature/splash/view/splash_view.dart';
import 'package:flutter_ui/feature/root/view/root_page_view.dart';
import 'package:flutter_ui/feature/unavailable/view/unavailable_view.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => SplashCubit(),
            child: const SplashView(),
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => AuthCubit(),
                child: const LoginView(),
              );
            },
          ),
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra as Map<String, dynamic>;
              final authCubit = extra['cubit'] as AuthCubit;
              return BlocProvider.value(
                value: authCubit,
                child: const RegisterView(),
              );
            },
          ),
          GoRoute(
            path: 'root_page',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => RootPageCubit(),
                child: const RootPageView(),
              );
            },
          ),
          GoRoute(
            path: 'unavailable',
            builder: (BuildContext context, GoRouterState state) {
              return const UnavailableView();
            },
          ),
          GoRoute(
            path: 'product_detail',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: (state.extra as Map<String, dynamic>)["cubit"]
                    as RootPageCubit,
                child: ProductDetailView(
                  productId:
                      (state.extra as Map<String, dynamic>)["productId"] as int,
                ),
              );
            },
          ),
          GoRoute(
            path: 'profile_favourites',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider.value(
                value: (state.extra as Map<String, dynamic>)["cubit"]
                    as RootPageCubit,
                child: ProfileFavouritesView(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
