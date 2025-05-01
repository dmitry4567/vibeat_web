import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/custom_functions.dart';
import 'package:vibeat_web/features/signIn/presentation/bloc/auth_bloc.dart';
import 'package:vibeat_web/widgets/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in_web/web_only.dart';

// final storage = FlutterSecureStorageWeb();

@RoutePage()
class SignInPage2 extends StatefulWidget {
  const SignInPage2({super.key});

  @override
  State<SignInPage2> createState() => _SignInPage2State();
}

class _SignInPage2State extends State<SignInPage2> {
  // final GoogleSignInPlatform _platform = GetIt.I<GoogleSignInPlatform>();
  final TextEditingController textController1 = TextEditingController(text: "d@gmail.com");
  final TextEditingController textController2 = TextEditingController(text: "1234");
  bool _isPasswordVisible = false;

  String _message = '';
  String? _jwtToken;
  Map<String, dynamic>? _userInfo;

  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return;

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Отправляем код авторизации на сервер
  //     final response = await dio.post(
  //       'http://192.168.0.135:7773/api/auth/google/getjwt',
  //       data: {
  //         'token': googleAuth.accessToken,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.data);
  //       await storage.write(
  //           key: 'jwt_token',
  //           value: responseData['token'],
  //           options: {'useSessionStorage': "false"});

  //       setState(() {
  //         _jwtToken = responseData['token'];
  //         _userInfo = responseData['user'];
  //         log('Успешная авторизация: ${_userInfo?['email']}');
  //       });
  //     } else {
  //       setState(() {
  //         _message = 'Ошибка сервера: ${response.statusCode}';
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       _message = 'Ошибка авторизации: $error';
  //     });
  //   }
  // }

  // Future<void> _logout() async {
  //   await _googleSignIn.signOut();
  //   await storage.delete(key: 'jwt_token', options: {});
  //   setState(() {
  //     _jwtToken = null;
  //     _userInfo = null;
  //     _message = 'Вы вышли из системы';
  //   });
  // }

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(GoogleJwtStream());
  }

  // Future<void> _checkAuth() async {
  //   _platform.userDataEvents!.listen((event) async {
  //     // Отправляем токен на сервер для верификации и получения JWT
  //     final response = await dio.post(
  //       'http://192.168.0.135:7773/api/auth/google/getjwt',
  //       options: d.Options(headers: {'Content-Type': 'application/json'}),
  //       data: json.encode({
  //         'token': event!.idToken,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = response.data;

  //       log(responseData.toString());
  //     } else {
  //       await _googleSignIn.signOut();
  //     }
  //   });
  // }

  GSIButtonConfiguration? _buttonConfiguration;

  void _handleNewWebButtonConfiguration(GSIButtonConfiguration newConfig) {
    setState(() {
      _buttonConfiguration = newConfig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisteredNewUser) {
          context.router.push(const AnketaRoute());
        } else if (state is Authenticated) {
          context.router.replaceAll([const HomeRoute()]);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            setupSnackBar(state.message),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff0C0C0C),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'icons/logo.svg',
                width: 125,
                height: 22,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 18,
                  right: 18,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 32,
                ),
                width: 376,
                decoration: BoxDecoration(
                  color: const Color(0xff191919),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Авторизация",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    const SizedBox(height: 32),
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
                            color: Color(0xff8D40FF),
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
                        fillColor: const Color(0xff262626),
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 7,
                          bottom: 7,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
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
                            color: Color(0xff8D40FF),
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
                        fillColor: const Color(0xff262626),
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 7,
                          bottom: 7,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'OpenSans',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
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
                          color: const Color(0xff8D40FF),
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
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        context.replaceRoute(const SignUpRoute());
                      },
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
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {},
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
                    const SizedBox(height: 20),
                    renderButton(configuration: _buttonConfiguration),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // _handleSignIn();
                          },
                          icon: SvgPicture.asset(
                            'icons/google.svg',
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'icons/yandex.svg',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
