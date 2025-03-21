import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_router.dart';

void main() {
  runApp(MyAppPage());
}

class MyAppPage extends StatelessWidget {
  final _appRouter = AppRouter();

  MyAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
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
                    context.router.replaceNamed('r2');
                  },
                  elevation: 0,
                  hoverColor: Colors.white12,
                  color: Colors.white12,
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
                    context.router.replaceNamed('r1');
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
