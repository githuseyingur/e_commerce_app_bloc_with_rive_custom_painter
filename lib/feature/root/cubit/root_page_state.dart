import 'package:equatable/equatable.dart';
import 'package:flutter_ui/product/global/model/user_model.dart';

class RootPageState extends Equatable {
  final int selectedPage;
  final List<int> favouriteProducts;
  final List<int> productListInCart;
  const RootPageState({
    required this.selectedPage,
    required this.favouriteProducts,
    required this.productListInCart,
  });
  factory RootPageState.initial() {
    return RootPageState(
      selectedPage: 0,
      favouriteProducts: user.favouriteProducts,
      productListInCart: const [],
    );
  }

  @override
  List<Object?> get props => [
        selectedPage,
        favouriteProducts,
        productListInCart,
      ];

  RootPageState copyWith({
    int? selectedPage,
    List<int>? favouriteProducts,
    List<int>? productListInCart,
  }) {
    return RootPageState(
      selectedPage: selectedPage ?? this.selectedPage,
      favouriteProducts: favouriteProducts ?? this.favouriteProducts,
      productListInCart: productListInCart ?? this.productListInCart,
    );
  }
}
