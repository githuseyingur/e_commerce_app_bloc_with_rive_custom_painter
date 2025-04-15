import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/feature/home/cubit/home_cubit.dart';
import 'package:flutter_ui/feature/home/view/home_view.dart';
import 'package:flutter_ui/feature/profile/view/profile_view.dart';
import 'package:flutter_ui/feature/root/cubit/root_page_state.dart';
import 'package:flutter_ui/product/global/model/user_model.dart';

class RootPageCubit extends Cubit<RootPageState> {
  RootPageCubit() : super(RootPageState.initial()) {
    init();
  }

  init() async {}

  void setPageIndex(int index) {
    emit(state.copyWith(selectedPage: index));
  }

  List<Widget> tabPages = [
    BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    ),
    Container(),
    Container(),
    Container(),
    const ProfileView(),
  ];

  void setFavourite(int productId) {
    final currentFavourites = List<int>.from(state.favouriteProducts);

    if (currentFavourites.contains(productId)) {
      currentFavourites.remove(productId);
      user.favouriteProducts.remove(productId);
    } else {
      currentFavourites.add(productId);
      user.favouriteProducts.add(productId);
    }

    emit(state.copyWith(favouriteProducts: currentFavourites));
  }

  void addToCart(int productId) {
    final productCardList = List<int>.from(state.productListInCart);
    productCardList.add(productId);
    emit(state.copyWith(productListInCart: productCardList));
  }

  void removeFromCart(int productId) {
    final productCardList = List<int>.from(state.productListInCart);
    productCardList.remove(productId);
    emit(state.copyWith(productListInCart: productCardList));
  }
}
