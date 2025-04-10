import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_state.dart';
import 'package:flutter_ui/feature/auth/widget/auth_form_field.dart';
import 'package:flutter_ui/product/components/main_button.dart';
import 'package:flutter_ui/product/components/custom_full_scrren_alertdialog.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:flutter_ui/product/helper/functions/get_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui/product/helper/extensions/validate_regex_extension.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 242, 245).withAlpha(250),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
          child: Form(
            key: context.read<AuthCubit>().registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 0.4.sw,
                    height: 0.4.sw,
                    child: const Icon(
                      Icons.woo_commerce,
                    )),
                Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    color: ColorConstants.textBlack,
                    fontSize: ResponsiveFontSize.optimusPrime(32),
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                AuthFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                  ],
                  onChanged: (value) {
                    if (!value.startsWith("+90")) {
                      context
                          .read<AuthCubit>()
                          .registerPhoneTextController
                          .text = "+90";
                      context
                          .read<AuthCubit>()
                          .registerPhoneTextController
                          .selection = TextSelection.fromPosition(
                        TextPosition(
                          offset: context
                              .read<AuthCubit>()
                              .registerPhoneTextController
                              .text
                              .length,
                        ),
                      );
                    }
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Telefon numarası boş bırakılamaz";
                    } else if (val.length < 13) {
                      return 'Lütfen 11 haneli telefon numarası giriniz';
                    }
                    return null;
                  },
                  controller:
                      context.read<AuthCubit>().registerPhoneTextController,
                  hintText: "Telefon numaranız",
                  hintColor: ColorConstants.textBlack.withAlpha(100),
                ),
                SizedBox(
                  height: 0.016.sh,
                ),
                AuthFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email adresi boş bırakılamaz";
                    } else if (!ValidateRegexExtension(val).isEmail) {
                      return 'Geçerli Bir Email Adresi Giriniz';
                    }
                    return null;
                  },
                  controller:
                      context.read<AuthCubit>().registerEmailTextController,
                  hintText: "Email adresiniz",
                  hintColor: ColorConstants.textBlack.withAlpha(100),
                ),
                SizedBox(
                  height: 0.016.sh,
                ),
                AuthFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Ad Soyad boş bırakılamaz";
                    } else if (val.length < 5) {
                      return 'Geçerli Bir Ad Soyad Giriniz';
                    }
                    return null;
                  },
                  controller:
                      context.read<AuthCubit>().registerFullnameController,
                  hintText: "Adınız Soyadınız",
                  hintColor: ColorConstants.textBlack.withAlpha(100),
                ),
                SizedBox(
                  height: 0.016.sh,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AuthFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Şifre boş bırakılamaz!";
                        } else if (val.length < 6) {
                          return 'Şifreniz en az 6 karakter olmalıdır!';
                        }
                        return null;
                      },
                      controller:
                          context.read<AuthCubit>().registerPasswordController,
                      hintText: "Şifreniz",
                      hintColor: ColorConstants.textBlack.withAlpha(100),
                      obscureText: state.isRegsiterObscure,
                      maxLines: 1,
                      obscuringCharacter: "*",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().setIsRegisterObscure(
                              !context
                                  .read<AuthCubit>()
                                  .state
                                  .isRegsiterObscure);
                        },
                        child: Icon(
                          state.isRegsiterObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorConstants.textBlack.withAlpha(100),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Checkbox(
                          side: BorderSide(
                            width: 0.8.w,
                            color: ColorConstants.textBlack,
                          ),
                          value: state.approvibleTextValue,
                          onChanged: (val) {
                            context
                                .read<AuthCubit>()
                                .setApprovibleTextValue(val!);
                          },
                          checkColor: Colors.white,
                          activeColor: ColorConstants.primaryGreen,
                        );
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Sıfıraraçal ',
                          style: TextStyle(
                            fontSize: ResponsiveFontSize.optimusPrime(15),
                            color: ColorConstants.textBlack,
                            letterSpacing: -0.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'Açık Rıza Metni',
                              style: TextStyle(
                                fontSize: ResponsiveFontSize.optimusPrime(15),
                                fontWeight: FontWeight.w300,
                                color: ColorConstants.textBlack,
                                decoration: TextDecoration.underline,
                                letterSpacing: 0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<AuthCubit>().setSelectedIndex(0);

                                  showDialog(
                                    context: context,
                                    builder: (contexttt) {
                                      return BlocProvider.value(
                                        value: context.read<AuthCubit>(),
                                        child: CustomFullScreenAlertDialog(
                                          title: "Açık Rıza Metni",
                                          alertBackgroundColor: Colors.white,
                                          alertTitleTextColor:
                                              ColorConstants.textBlack,
                                          alertTitleTextFontSize:
                                              ResponsiveFontSize.optimusPrime(
                                                  18),
                                          alertTitleTextBackgroundColor:
                                              ColorConstants.textBlack,
                                          backOnTap: () {
                                            context.pop();
                                          },
                                          widget:
                                              BlocBuilder<AuthCubit, AuthState>(
                                            builder: (context, state) {
                                              return SizedBox(
                                                width: 0.9.sw,
                                                child: Text(
                                                  state.text,
                                                  style: TextStyle(
                                                    fontSize: ResponsiveFontSize
                                                        .optimusPrime(16),
                                                    color: ColorConstants
                                                        .textBlack
                                                        .withAlpha(180),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                            ),
                            TextSpan(
                              text:
                                  "'ni okudum ve verilerimin işlenmesine onay veriyorum.",
                              style: TextStyle(
                                fontSize: ResponsiveFontSize.optimusPrime(15),
                                fontWeight: FontWeight.w300,
                                color: ColorConstants.textBlack,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Checkbox(
                          side: BorderSide(
                              width: 0.8.w, color: ColorConstants.textBlack),
                          value: state.contractTextValue,
                          onChanged: (val) {
                            context
                                .read<AuthCubit>()
                                .setContractTextValue(val!);
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                        );
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Sıfıraraçal ',
                          style: TextStyle(
                            fontSize: ResponsiveFontSize.optimusPrime(15),
                            color: ColorConstants.textBlack,
                            letterSpacing: -0.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'Gizlilik Sözleşmesi',
                              style: TextStyle(
                                fontSize: ResponsiveFontSize.optimusPrime(15),
                                fontWeight: FontWeight.w300,
                                color: ColorConstants.textBlack,
                                decoration: TextDecoration.underline,
                                letterSpacing: 0,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<AuthCubit>().setSelectedIndex(1);

                                  showDialog(
                                    context: context,
                                    builder: (contexttt) {
                                      return BlocProvider.value(
                                        value: context.read<AuthCubit>(),
                                        child: CustomFullScreenAlertDialog(
                                          title: "Gizlilik Sözleşmesi",
                                          alertBackgroundColor: Colors.white,
                                          alertTitleTextColor:
                                              ColorConstants.textBlack,
                                          alertTitleTextFontSize:
                                              ResponsiveFontSize.optimusPrime(
                                                  18),
                                          alertTitleTextBackgroundColor:
                                              ColorConstants.textBlack,
                                          backOnTap: () {
                                            context.pop();
                                          },
                                          widget:
                                              BlocBuilder<AuthCubit, AuthState>(
                                            builder: (context, state) {
                                              return SizedBox(
                                                width: 0.9.sw,
                                                child: Text(
                                                  state.text,
                                                  style: TextStyle(
                                                    fontSize: ResponsiveFontSize
                                                        .optimusPrime(16),
                                                    color: ColorConstants
                                                        .textBlack
                                                        .withAlpha(180),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                            ),
                            TextSpan(
                              text: "'ni okudum ve onay veriyorum.",
                              style: TextStyle(
                                fontSize: ResponsiveFontSize.optimusPrime(15),
                                fontWeight: FontWeight.w300,
                                color: ColorConstants.textBlack,
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: !state.approvibleTextValue ||
                          !state.contractTextValue,
                      child:
                          Text("Lütfen üstteki metinleri okuyup onay veriniz.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: ResponsiveFontSize.optimusPrime(14),
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 0.024.sh,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.registerState == RegisterStates.error) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(
                          type: SnackbarEnum.error,
                          text: state.errorMessage,
                        ),
                      );
                    } else if (state.registerState ==
                        RegisterStates.completed) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(
                          type: SnackbarEnum.success,
                          text: state.message,
                        ),
                      );
                      context.pushReplacement("/login");
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: 1.sw,
                      child: MainButton(
                        onPressed: state.registerState == RegisterStates.loading
                            ? () {}
                            : () {
                                String phone = context
                                    .read<AuthCubit>()
                                    .registerPhoneTextController
                                    .text;
                                String email = context
                                    .read<AuthCubit>()
                                    .registerEmailTextController
                                    .text;
                                String nameSurname = context
                                    .read<AuthCubit>()
                                    .registerFullnameController
                                    .text;

                                String password = context
                                    .read<AuthCubit>()
                                    .registerPasswordController
                                    .text;
                                if (context
                                    .read<AuthCubit>()
                                    .registerFormKey
                                    .currentState!
                                    .validate()) {
                                  if (state.approvibleTextValue &&
                                      state.contractTextValue) {
                                    // context.read<AuthCubit>().register(
                                    //     phone, email, nameSurname, password);
                                    print("nameee: $nameSurname");
                                  } else {}
                                }
                              },
                        title: state.registerState == RegisterStates.loading
                            ? 'KAYıt OlUŞTURULUYOR'
                            : "KAYIT OL",
                        themeColor: ButtonThemeColors.green,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                SizedBox(
                  width: 1.sw,
                  child: MainButton(
                    onPressed: () {
                      context.pop();
                    },
                    title: "GERİ DÖN",
                    themeColor: ButtonThemeColors.gray,
                  ),
                ),
                const Spacer(
                  flex: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
