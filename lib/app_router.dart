import 'package:auto_route/auto_route.dart';
import 'package:vibeat_web/main.dart';
import 'package:vibeat_web/sign_in_widget.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

part 'app_router.gr.dart'; // Генерируемый файл

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          path: '/signIn',
          initial: true,
          page: SignInRoute.page,
        ),
        AutoRoute(
          path: '/app',
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          page: HomeRoute.page,
          children: [
            AutoRoute(
              path: 'r1',
              initial: true,
              type: const RouteType.custom(
                transitionsBuilder: TransitionsBuilders.noTransition,
              ),
              page: Routen1Route.page,
            ),
            CustomRoute(
              path: 'r2',
              page: Routen2Route.page,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              path: 'r3',
              page: Routen3Route.page,
              transitionsBuilder: TransitionsBuilders.noTransition,
            )
          ],
        ),
      ];
}
