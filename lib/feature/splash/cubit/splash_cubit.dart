import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/core/network/network_manager/network_manager.dart';
import 'package:flutter_ui/feature/splash/cubit/splash_state.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/global/service/global_service.dart';
import 'package:flutter_ui/product/global/service/i_global_service.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial()) {
    init();
  }

  init() async {
    await fetchProducts();
  }

  final IGlobalService globalService = GlobalService(NetworkManager.instance);

  Future<void> fetchProducts() async {
    emit(
      state.copyWith(
        productState: ProductStates.loading,
        errorMessage: '',
        message: '',
      ),
    );

    final response = await globalService.fetchProducts();

    if (response != null) {
      List<dynamic> productDataList = response as List<dynamic>;
      productList = productDataList
          .map((dynamic item) =>
              ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();

      emit(
        state.copyWith(
          productState: ProductStates.completed,
          message: "Data fetched successfully.",
        ),
      );
    } else {
      emit(
        state.copyWith(
          productState: ProductStates.error,
          errorMessage:
              "Failed to retrieve data from the server. Please check your connection or try again later.",
        ),
      );
    }
  }

  void setProductStateToInitial() {
    emit(state.copyWith(
      productState: ProductStates.initial,
      errorMessage: '',
      message: '',
    ));
  }
}
