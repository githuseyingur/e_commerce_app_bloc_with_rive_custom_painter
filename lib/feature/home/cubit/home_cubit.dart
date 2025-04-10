import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/feature/home/cubit/home_state.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/global/model/user_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()) {
    init();
  }

  init() async {}

  void setCategory(String category) {
    emit(state.copyWith(
        selectedCategory: category,
        filteredProductList:
            productList.where((p) => p.category!.name! == category).toList()));
  }

  void setFavourite(int productId) {
    if (state.favouriteProducts.contains(productId)) {
      emit(state.copyWith(
          favouriteProducts: state.favouriteProducts..remove(productId)));
      // user.favouriteProducts.remove(productId);
    } else {
      emit(state.copyWith(
          favouriteProducts: state.favouriteProducts..add(productId)));
      // user.favouriteProducts.add(productId);
    }
  }
}
