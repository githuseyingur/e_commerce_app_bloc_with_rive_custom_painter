import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_cubit.dart';
import 'package:flutter_ui/feature/auth/cubit/auth_state.dart';
import 'package:flutter_ui/feature/auth/widget/auth_form_field.dart';
import 'package:flutter_ui/product/components/main_button.dart';
import 'package:flutter_ui/product/constant/color_constants.dart';
import 'package:flutter_ui/product/helper/extensions/optimus_prime.dart';
import 'package:flutter_ui/product/helper/functions/get_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui/product/helper/extensions/validate_regex_extension.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackground,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.1.sh),
          child: Form(
            key: context.read<AuthCubit>().loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.1.sw, vertical: 0.01.sh),
                    child: Icon(
                      Icons.store,
                      color: ColorConstants.primaryGreen,
                      size: ResponsiveFontSize.optimusPrime(48),
                    )),
                SizedBox(
                  height: 0.02.sh,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: ColorConstants.primaryGreen,
                    fontSize: ResponsiveFontSize.optimusPrime(34),
                  ),
                ),
                SizedBox(
                  height: 0.04.sh,
                ),
                AuthFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "This field cannot be empty.";
                    } else if (ValidateRegexExtension(val).isEmail ||
                        ValidateRegexExtension(val).isPhone) {
                    } else {
                      return 'Please enter a valid email or phone number!..';
                    }
                    return null;
                  },
                  controller:
                      context.read<AuthCubit>().loginPhoneEmailTextController,
                  hintText: "Email or Phone number",
                  hintColor: ColorConstants.textBlack.withAlpha(100),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 0.016.sh,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return AuthFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "This field cannot be empty.";
                        } else if (val.length < 6) {
                          return 'Password must be at least 6 characters!';
                        }
                        return null;
                      },
                      controller:
                          context.read<AuthCubit>().loginPasswordTextController,
                      hintText: "Password",
                      hintColor: ColorConstants.textBlack.withAlpha(100),
                      obscureText: state.isLoginObscure,
                      maxLines: 1,
                      obscuringCharacter: "*",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          context
                              .read<AuthCubit>()
                              .setIsLoginObscure(!state.isLoginObscure);
                        },
                        child: Icon(
                          state.isLoginObscure
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: ColorConstants.textBlack.withAlpha(100),
                          size: ResponsiveFontSize.optimusPrime(20),
                        ),
                      ),
                      prefixIcon: SizedBox(
                        width: ResponsiveFontSize.optimusPrime(20),
                      ),
                    );
                  },
                ),
                SizedBox(height: 0.016.sh),
                GestureDetector(
                  onTap: () {
                    context.push('/reset_password');
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveFontSize.optimusPrime(16),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (contextt, state) {
                    if (state.authState == AuthStates.error) {
                      context.read<AuthCubit>().setToAuthStateInitial();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(
                          text: state.errorMessage,
                          snackBarType: SnackBarType.dark,
                        ),
                      );
                    } else if (state.authState == AuthStates.completed) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(
                          text: "You have successfully logged in.",
                          snackBarType: SnackBarType.dark,
                        ),
                      );
                      context.pushReplacement("/root_page");
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: 1.sw,
                      child: MainButton(
                        onPressed: state.authState == AuthStates.loading
                            ? () {}
                            : () async {
                                if (context
                                    .read<AuthCubit>()
                                    .loginFormKey
                                    .currentState!
                                    .validate()) {
                                  String username = context
                                      .read<AuthCubit>()
                                      .loginPhoneEmailTextController
                                      .text;
                                  String password = context
                                      .read<AuthCubit>()
                                      .loginPasswordTextController
                                      .text;

                                  // await context
                                  //     .read<AuthCubit>()
                                  //     .login(username, password);
                                } else {}
                                context.push('/root_page');
                              },
                        title: state.authState == AuthStates.loading
                            ? 'SIGNING IN...'
                            : "SIGN IN",
                        themeColor: ButtonThemeColors.green,
                      ),
                    );
                  },
                ),
                SizedBox(height: 0.03.sh),
                Text(
                  "Don't you have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveFontSize.optimusPrime(18),
                  ),
                ),
                SizedBox(height: 0.03.sh),
                SizedBox(
                  width: 1.sw,
                  child: MainButton(
                    onPressed: () {
                      context.push("/register",
                          extra: {'cubit': context.read<AuthCubit>()});
                    },
                    title: "REGISTER",
                    themeColor: ButtonThemeColors.gray,
                  ),
                ),
                SizedBox(height: 0.03.sh),
                SizedBox(
                  width: 1.sw,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.guestState == GuestStates.error) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            text: state.errorMessage,
                            snackBarType: SnackBarType.light,
                          ),
                        );
                      } else if (state.guestState == GuestStates.completed) {
                        context.pushReplacement("/root_page");
                      }
                    },
                    builder: (context, state) {
                      return MainButton(
                        onPressed: () {
                          // context.read<AuthCubit>().guestLogin();
                        },
                        title: state.guestState == GuestStates.loading
                            ? 'SIGNING IN...'
                            : 'CONTINUE AS GUEST',
                        themeColor: ButtonThemeColors.gray,
                      );
                    },
                  ),
                ),
                const Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
