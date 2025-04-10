import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.authState,
    required this.productState,
    required this.errorMessage,
    required this.message,
    required this.contentIndex,
    required this.isAlertContentMain,
    required this.tabIndex,
    required this.contractTextValue,
    required this.approvibleTextValue,
    required this.isRegsiterObscure,
    required this.isLoginObscure,
    required this.registerState,
    required this.guestState,
    required this.text,
    required this.selectedIndex,
  });
  factory AuthState.initial() {
    return const AuthState(
      authState: AuthStates.initial,
      productState: ProductStates.initial,
      errorMessage: '',
      message: '',
      contentIndex: 0,
      isAlertContentMain: true,
      tabIndex: 0,
      contractTextValue: false,
      approvibleTextValue: false,
      isRegsiterObscure: true,
      isLoginObscure: true,
      registerState: RegisterStates.initial,
      guestState: GuestStates.initial,
      text: '',
      selectedIndex: 0,
    );
  }
  final AuthStates authState;
  final ProductStates productState;

  final String errorMessage;
  final String message;
  final int contentIndex;
  final bool isAlertContentMain;
  final int tabIndex;
  final bool contractTextValue;
  final bool approvibleTextValue;
  final bool isRegsiterObscure;
  final bool isLoginObscure;
  final RegisterStates registerState;
  final GuestStates guestState;
  final String text;
  final int selectedIndex;

  @override
  List<Object?> get props => [
        authState,
        productState,
        errorMessage,
        message,
        contentIndex,
        isAlertContentMain,
        tabIndex,
        contractTextValue,
        approvibleTextValue,
        isRegsiterObscure,
        isLoginObscure,
        registerState,
        guestState,
        text,
        selectedIndex,
      ];

  AuthState copyWith({
    AuthStates? authState,
    ProductStates? productState,
    String? errorMessage,
    String? message,
    int? contentIndex,
    bool? isAlertContentMain,
    int? tabIndex,
    bool? contractTextValue,
    bool? approvibleTextValue,
    bool? isRegsiterObscure,
    bool? isLoginObscure,
    RegisterStates? registerState,
    GuestStates? guestState,
    String? text,
    int? selectedIndex,
  }) {
    return AuthState(
      authState: authState ?? this.authState,
      productState: productState ?? this.productState,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      contentIndex: contentIndex ?? this.contentIndex,
      isAlertContentMain: isAlertContentMain ?? this.isAlertContentMain,
      tabIndex: tabIndex ?? this.tabIndex,
      contractTextValue: contractTextValue ?? this.contractTextValue,
      approvibleTextValue: approvibleTextValue ?? this.approvibleTextValue,
      isRegsiterObscure: isRegsiterObscure ?? this.isRegsiterObscure,
      isLoginObscure: isLoginObscure ?? this.isLoginObscure,
      registerState: registerState ?? this.registerState,
      guestState: guestState ?? this.guestState,
      text: text ?? this.text,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

enum AuthStates {
  initial,
  loading,
  completed,
  error,
}

enum RegisterStates {
  initial,
  loading,
  completed,
  error,
}

enum ProductStates {
  initial,
  loading,
  completed,
  error,
}

enum GuestStates {
  initial,
  loading,
  completed,
  error,
}
