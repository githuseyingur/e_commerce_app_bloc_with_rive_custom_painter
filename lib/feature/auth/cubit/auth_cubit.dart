import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/core/network/network_manager/network_manager.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_state.dart';
import 'package:flutter_ui/product/constant/app_constants.dart';
import 'package:flutter_ui/product/global/model/product_model.dart';
import 'package:flutter_ui/product/global/service/global_service.dart';
import 'package:flutter_ui/product/global/service/i_global_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial()) {
    init();
  }

  init() async {
    await fetchProducts();
  }

  //* controller
  final TextEditingController loginPhoneEmailTextController =
      TextEditingController();
  final TextEditingController loginPasswordTextController =
      TextEditingController();
  final TextEditingController registerPhoneTextController =
      TextEditingController();
  final TextEditingController registerEmailTextController =
      TextEditingController();
  final TextEditingController registerFullnameController =
      TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController resetPasswordPhoneNumberController =
      TextEditingController();

//* key
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final IGlobalService globalService = GlobalService(NetworkManager.instance);

  void setContractTextValue(bool value) {
    emit(state.copyWith(contractTextValue: value));
  }

  void setApprovibleTextValue(bool value) {
    emit(state.copyWith(approvibleTextValue: value));
  }

  void setIsRegisterObscure(bool value) {
    emit(state.copyWith(isRegsiterObscure: value));
  }

  void setIsLoginObscure(bool value) {
    emit(state.copyWith(isLoginObscure: value));
  }

  void setStatesToInitial() {
    emit(state.copyWith(authState: AuthStates.initial));
  }

  // Future<void> login(String emailOrPhone, String password) async {
  //   emit(state.copyWith(
  //       authState: AuthStates.loading, errorMessage: '', message: ''));

  //   try {
  //     final response = await authService.login(emailOrPhone, password);

  //     if (response != null) {
  //       customer = CustomerModel.fromJson(response);

  //       customerLikeList = customer.likeIds!.trim().split(',');
  //       customerDislikeList = customer.disLikeIds!.trim().split(',');

  //       emit(state.copyWith(
  //         authState: AuthStates.completed,
  //         message: "Giriş Başarılı Veriler Çekiliyor...",
  //         brandState: BrandStates.loading,
  //       ));

  //       final result = await globalService.getAllBrand();
  //       if (result != null) {
  //         List<dynamic> dataList = result as List<dynamic>;
  //         List<Brand> brandCarList = dataList
  //             .map((dynamic item) =>
  //                 Brand.fromJson(item as Map<String, dynamic>))
  //             .toList();
  //         brandList = brandCarList;
  //         emit(state.copyWith(brandState: BrandStates.completed));
  //         getFavoriteCar();
  //       }
  //     }
  //   } catch (e) {
  //     String errorMessage = e.toString();
  //     if (errorMessage.contains('Kullanıcı adı veya şifre hatalı')) {
  //       errorMessage = 'Kullanıcı adı veya şifre hatalı';
  //     } else if (errorMessage.contains('Sunucu hatası')) {
  //       errorMessage = 'Sunucu hatası! Lütfen daha sonra tekrar deneyin.';
  //     } else {
  //       errorMessage = 'Bağlantı hatası! Lütfen daha sonra tekrar deneyin.';
  //     }

  //     emit(state.copyWith(
  //         authState: AuthStates.error, errorMessage: errorMessage));
  //   }
  // }

  // Future<void> register(String phoneNumber, String emailorPhone, String name,
  //     String password) async {
  //   emit(state.copyWith(registerState: RegisterStates.loading));

  //   final registerMOdel = RegisterModel(
  //     email: emailorPhone,
  //     phoneNumber: phoneNumber,
  //     name: name,
  //     password: password,
  //   );
  //   final response = await authService.register(registerMOdel);
  //   if (response != null) {
  //     emit(state.copyWith(
  //         registerState: RegisterStates.completed, message: "Kayıt Başarılı"));
  //     final loginResponse = await authService.login(emailorPhone, password);

  //     if (loginResponse != null) {
  //       //  emit(state.copyWith(
  //       // registerState: .completed, message: "Kayıt Başarılı"));
  //     } else {
  //       emit(state.copyWith(
  //           registerState: RegisterStates.error,
  //           errorMessage:
  //               'Bağlantı hatası! Lütfen daha sonra tekrar deneyin.'));
  //     }
  //   } else {
  //     emit(state.copyWith(
  //         registerState: RegisterStates.error,
  //         errorMessage: 'Bağlantı hatası! Lütfen daha sonra tekrar deneyin.'));
  //   }
  // }

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

  //* guest account
  // Future<void> guestLogin() async {
  //   emit(state.copyWith(guestState: GuestStates.loading, errorMessage: ''));
  //   try {
  //     customer = CustomerModel(
  //       id: 0,
  //       email: '',
  //       name: 'Misafir',
  //       phoneNumber: '',
  //       password: '',
  //       ab: false,
  //       city: '',
  //       cityID: 0,
  //       createdDate: DateTime.now().toUtc().toIso8601String(),
  //       createdIp: '',
  //       createdTime: '',
  //       district: '',
  //       districtID: 0,
  //       guid: '',
  //       isActive: true,
  //       sal: true,
  //       sayisalYedek1: 0,
  //       sayisalYedek2: 0,
  //       textYedek1: '',
  //       textYedek2: '',
  //     );

  //     final result = await globalService.getAllBrand();
  //     if (result != null) {
  //       List<dynamic> dataList = result as List<dynamic>;
  //       List<Brand> brandCarList = dataList
  //           .map((dynamic item) => Brand.fromJson(item as Map<String, dynamic>))
  //           .toList();
  //       brandList = brandCarList;
  //       brandList.sort((a, b) => a.name!.compareTo(b.name!));
  //       emit(state.copyWith(guestState: GuestStates.completed));
  //     }
  //   } catch (e) {
  //     String errorMessage = e.toString();
  //     {
  //       errorMessage = 'Bağlantı hatası! Lütfen daha sonra tekrar deneyin.';
  //     }

  //     emit(state.copyWith(
  //         guestState: GuestStates.error, errorMessage: errorMessage));
  //   }
  // }

  void setProductStateToInitial() {
    emit(state.copyWith(
      productState: ProductStates.initial,
      errorMessage: '',
      message: '',
    ));
  }

  void setToAuthStateInitial() {
    emit(state.copyWith(
      authState: AuthStates.initial,
      errorMessage: '',
      message: '',
    ));
  }

  void setSelectedIndex(int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex));
    switch (state.selectedIndex) {
      case 0:
        emit(state.copyWith(text: AppConstants.personalDataSharingText));
        break;
      case 1:
        emit(state.copyWith(text: AppConstants.privacyPolicyText));
        break;
    }
  }
}
