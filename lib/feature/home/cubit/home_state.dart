import 'package:equatable/equatable.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.homeState,
    required this.selectedCategory,
    required this.filteredProductList,
  });
  factory HomeState.initial() {
    return HomeState(
      homeState: HomeStates.initial,
      selectedCategory: productList[0].category!.name!,
      filteredProductList: productList
          .where((p) => p.category!.name! == productList[0].category!.name!)
          .toList(),
    );
  }
  final HomeStates homeState;
  final String selectedCategory;

  final List<ProductModel> filteredProductList;

  @override
  List<Object?> get props => [
        homeState,
        selectedCategory,
        filteredProductList,
      ];

  HomeState copyWith({
    HomeStates? homeState,
    String? selectedCategory,
    List<ProductModel>? filteredProductList,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredProductList: filteredProductList ?? this.filteredProductList,
    );
  }
}

enum HomeStates {
  initial,
  loading,
  completed,
  error,
}
