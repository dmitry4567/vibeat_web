import 'package:auto_route/auto_route.dart';
import 'package:vibeat_web/all_license_page.dart';
import 'package:vibeat_web/main.dart';
import 'package:vibeat_web/sign_in_widget.dart';
import 'package:vibeat_web/sign_up_widget.dart';

import 'edit_beat_page.dart';
import 'all_beats_page.dart';
import 'edit_license_page.dart';

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
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          path: '/signUp',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          path: '/app',
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          page: HomeRoute.page,
          children: [
            AutoRoute(
              path: 'editBeat',
              type: const RouteType.custom(
                transitionsBuilder: TransitionsBuilders.noTransition,
              ),
              page: EditBeatRoute.page,
            ),
            CustomRoute(
              path: 'allBeats',
              page: AllBeatsRoute.page,
              initial: true,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              path: 'allLicense',
              page: AllLicenseRoute.page,
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            AutoRoute(
              path: 'editLicense',
              type: const RouteType.custom(
                transitionsBuilder: TransitionsBuilders.noTransition,
              ),
              page: EditLicenseRoute.page,
            ),
          ],
        ),
      ];
}
