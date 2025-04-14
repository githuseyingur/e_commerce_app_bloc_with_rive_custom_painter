import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({
    required this.productState,
    required this.errorMessage,
    required this.message,
  });
  factory SplashState.initial() {
    return const SplashState(
      productState: ProductStates.initial,
      errorMessage: '',
      message: '',
    );
  }
  final ProductStates productState;

  final String errorMessage;
  final String message;

  @override
  List<Object?> get props => [
        productState,
        errorMessage,
        message,
      ];

  SplashState copyWith({
    ProductStates? productState,
    String? errorMessage,
    String? message,
  }) {
    return SplashState(
      productState: productState ?? this.productState,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
    );
  }
}

enum ProductStates {
  initial,
  loading,
  completed,
  error,
}
