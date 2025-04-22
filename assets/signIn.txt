import 'dart:convert';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vibeat/app/app_router.gr.dart';
import 'package:vibeat/custom_functions.dart';
import 'package:vibeat/features/signIn/presentation/bloc/auth_bloc.dart';
import 'package:vibeat/utils/theme.dart';
import 'package:vibeat/widgets/primary_button.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisteredNewUser) {
          context.router.push(const AnketaRoute());
        } else if (state is Authenticated) {
          context.router.push(const SearchRoute());
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            setupSnackBar(state.message),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'АВТОРИЗАЦИЯ',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Helvetica',
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: textController1,
                        obscureText: false,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundFilterTextField,
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 7,
                              bottom: 7,
                            )),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: textController2,
                        obscureText: !_isPasswordVisible,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'Пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.4),
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundFilterTextField,
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                              top: 7,
                              bottom: 7,
                            )),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Helvetica',
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Я забыл пароль",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (textController1.text.isEmpty ||
                                textController2.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                setupSnackBar('Заполните все поля'),
                              );
                            } else {
                              context.read<AuthBloc>().add(
                                    SignInEmailPasswordRequested(
                                      email: textController1.text,
                                      password: textController2.text,
                                    ),
                                  );
                            }
                          },
                          text: 'Войти',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: double.infinity,
                            color: AppColors.primary,
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              context
                                  .read<AuthBloc>()
                                  .add(GoogleSignInRequested());
                            },
                            icon: SvgPicture.asset(
                              'assets/svg/google.svg',
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/svg/yandex.svg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          context.replaceRoute(const SignUpRoute());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            'Зарегистрироваться',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Helvetica',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
