import 'dart:convert';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vibeat_web/app/app_router.dart';
import 'package:vibeat_web/app/injection_container.dart';
import 'package:vibeat_web/widgets/primary_button.dart';
import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:google_sign_in_web/web_only.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:vibeat_web/main.dart';

final storage = FlutterSecureStorageWeb();

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  bool _isPasswordVisible = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '862400550094-hunfctlkdt0hliqmkbvevafrg5v4cjd3.apps.googleusercontent.com',
    scopes: [
      'email',
      'profile',
      'openid',
    ],
    hostedDomain: '',
  );

  final dio = d.Dio();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    sl<GoogleSignInPlatform>().userDataEvents!.listen((event) async {
      // Отправляем токен на сервер для верификации и получения JWT
      final response = await dio.post(
        'https://4a39-111-96-144-229.ngrok-free.app/api/auth/google/getjwt',
        options: d.Options(headers: {'Content-Type': 'application/json'}),
        data: json.encode({
          'token': event!.idToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        log(responseData.toString());
      } else {
        await _googleSignIn.signOut();
      }
    });
  }

  GSIButtonConfiguration? _buttonConfiguration;

  void _handleNewWebButtonConfiguration(GSIButtonConfiguration newConfig) {
    setState(() {
      _buttonConfiguration = newConfig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
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
                      fontSize: 16,
                      height: 1,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Helvetica',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FFButtonWidget(
                      onPressed: () {
                        context.router.pushAndPopUntil(
                          const HomeRoute(),
                          predicate: (_) => false,
                        );
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
                      context.router.pushAndPopUntil(
                        const SignUpRoute(),
                        predicate: (_) => false,
                      );
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
                          _checkAuth();
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/google.svg',
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/yandex.svg',
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
    );
  }
}
