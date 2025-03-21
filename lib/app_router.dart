import 'package:auto_route/auto_route.dart';
import 'package:vibeat_web/main.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

part 'app_router.gr.dart'; // Генерируемый файл

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: HomeRoute.page,
          children: [
            CustomRoute(
              path: 'r1',
              page: Routen1Route.page,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              path: 'r2',
              page: Routen2Route.page,
              initial: true,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              path: 'r3',
              page: Routen3Route.page,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
          ],
        ),
      ];
}
