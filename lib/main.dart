import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibeat_web/features/allBeats/presentation/bloc/all_beats_bloc.dart';
import 'package:vibeat_web/features/allLicenses/presentation/bloc/bloc/all_licenses_bloc.dart';
import 'package:vibeat_web/features/anketa/presentation/bloc/anketa_bloc.dart';
import 'package:vibeat_web/features/signIn/presentation/bloc/auth_bloc.dart';
import 'app/app_router.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'app/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    log(errorDetails.toString());
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString());
    return true;
  };

  setUrlStrategy(PathUrlStrategy());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>(),
        ),
        // BlocProvider(
        //   create: (context) => di.sl<AnketaBloc>(),
        // ),
        BlocProvider(
          create: (context) => di.sl<AllBeatBloc>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AllLicensesBloc>(),
        ),
      ],
      child: MyAppPage(),
    ),
  );
}

class MyAppPage extends StatelessWidget {
  final _appRouter = AppRouter();

  MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0C0C0C),
        primarySwatch: Colors.blue,
      ),
    );
  }
}

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C0C0C),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // toolbarHeight: 54,
        backgroundColor: const Color(0xff0C0C0C),
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'vi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    fontFamily: "OpenSans",
                  ),
                ),
                TextSpan(
                  text: 'Beat',
                  style: TextStyle(
                    color: Color(0xff8D40FF),
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    fontFamily: "OpenSans",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 14,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "icantluvv",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 34),
            width: 200,
            color: const Color(0xff0C0C0C),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    "ОСНОВНОЕ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                MaterialButton(
                  onPressed: () {
                    context.router.replaceNamed('allBeats');
                  },
                  elevation: 0,
                  hoverColor: Colors.white12,
                  // color: Colors.white12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 10), // Отступ слева
                      Text(
                        'Каталог битов',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    context.router.replaceNamed('allLicense');
                  },
                  elevation: 0,
                  hoverColor: Colors.white12,
                  // color: Colors.white12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 10), // Отступ слева
                      Text(
                        'Лицензии',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    // context.router.replaceNamed('');
                  },
                  elevation: 0,
                  hoverColor: Colors.white12,
                  // color: Colors.white12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Отступ слева
                      Text(
                        'Аналитика',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: AutoRouter(),
          ),
        ],
      ),
    );
  }
}
