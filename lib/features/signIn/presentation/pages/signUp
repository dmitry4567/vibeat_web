import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibeat/app/app_router.gr.dart';
import 'package:vibeat/custom_functions.dart';
import 'package:vibeat/features/signIn/presentation/bloc/auth_bloc.dart';
import 'package:vibeat/toggle_icon_widget.dart';
import 'package:vibeat/utils/theme.dart';
import 'package:vibeat/widgets/primary_button.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;

  late bool passwordVisibility;
  late bool passwordVisibility2;
  late bool againPasswordVisibility;
  late bool privacyLicenseBool;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    passwordVisibility = false;
    passwordVisibility2 = false;
    againPasswordVisibility = false;
    privacyLicenseBool = false;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    super.dispose();
  }

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
                        'РЕГИСТРАЦИЯ',
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
                            hintText: 'Никнейм',
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
                        controller: textController3,
                        obscureText: !passwordVisibility,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'Пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.4),
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
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
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        controller: textController4,
                        obscureText: !passwordVisibility2,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'Повторите пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisibility2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.4),
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisibility2 = !passwordVisibility2;
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
                      const SizedBox(height: 10),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ToggleIcon(
                                onPressed: () {
                                  setState(() {
                                    privacyLicenseBool = !privacyLicenseBool;
                                  });
                                },
                                value: privacyLicenseBool,
                                onIcon: const Icon(
                                  Icons.check_box,
                                  color: Color(0xff8D40FF),
                                  size: 20,
                                ),
                                offIcon: Icon(
                                  Icons.check_box_outline_blank,
                                  color: privacyLicenseBool
                                      ? const Color(0xff8D40FF)
                                      : Colors.white.withOpacity(0.5),
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 14, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Настоящим подтверждаю, что я ознакомлен и согласен с условиями ',
                                        style: TextStyle(
                                          fontFamily: 'Helvetica',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Text(
                                          'политики конфиденциальности',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xff8D40FF),
                                            fontWeight: FontWeight.w400,
                                            height: 1.4,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color(0xff8D40FF),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (textController1!.text.isEmpty ||
                                textController2!.text.isEmpty ||
                                textController3!.text.isEmpty ||
                                textController4!.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  setupSnackBar("Заполните все поля"));
                            } else if (textController3!.text !=
                                textController4!.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  setupSnackBar("Пароли не совпадают"));
                            } else if (!privacyLicenseBool) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  setupSnackBar(
                                      "Необходимо подтвердить условия политики конфиденциальности"));
                            } else {
                              context.read<AuthBloc>().add(
                                    SignUpEmailPasswordRequested(
                                      email: textController2!.text,
                                      password: textController3!.text,
                                    ),
                                  );
                            }
                          },
                          text: 'Зарегистрироваться',
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
                          context.replaceRoute(const SignInRoute());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            'Уже есть аккаунт?',
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
