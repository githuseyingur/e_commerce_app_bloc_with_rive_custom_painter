import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/product/global/model/user_model.dart';

class RootPageState extends Equatable {
  final int selectedPage;
  final List<int> favouriteProducts;
  const RootPageState({
    required this.selectedPage,
    required this.favouriteProducts,
  });
  factory RootPageState.initial() {
    return RootPageState(
      selectedPage: 0,
      favouriteProducts: user.favouriteProducts,
    );
  }

  @override
  List<Object?> get props => [
        selectedPage,
        favouriteProducts,
      ];

  RootPageState copyWith({
    int? selectedPage,
    List<int>? favouriteProducts,
  }) {
    return RootPageState(
      selectedPage: selectedPage ?? this.selectedPage,
      favouriteProducts: favouriteProducts ?? this.favouriteProducts,
    );
  }
}
