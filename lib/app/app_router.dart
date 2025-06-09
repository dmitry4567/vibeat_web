import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:vibeat_web/features/allLicenses/presentation/pages/all_license_page.dart';
import 'package:vibeat_web/features/allBeats/domain/entities/beat_entity.dart';
import 'package:vibeat_web/main.dart';
import 'package:vibeat_web/features/anketa/presentation/pages/anketa_web.dart';
import 'package:vibeat_web/features/signIn/presentation/bloc/auth_bloc.dart';
import 'package:vibeat_web/features/signIn/presentation/pages/sign_in_widget.dart';
import 'package:vibeat_web/features/signIn/presentation/pages/sign_up_widget.dart';
import 'package:vibeat_web/_.dart';

import '../features/editBeat/presentation/pages/edit_beat_page.dart';
import '../features/allBeats/presentation/pages/all_beats_page.dart';
import '../features/editLicense/edit_license_page.dart';

part 'app_router.gr.dart'; // Генерируемый файл

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/app',
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          page: HomeRoute.page,
          guards: [AuthGuard()],
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
              transitionsBuilder: TransitionsBuilders.noTransition,
            ),
            CustomRoute(
              path: 'allLicense',
              initial: true,
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
        AutoRoute(
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          path: '/signIn',
          initial: true,
          page: SignInRoute2.page,
        ),
        AutoRoute(
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          path: '/signUp',
          page: SignUpRoute.page,
        ),
        AutoRoute(
          type: const RouteType.custom(
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          path: '/anketa',
          page: AnketaRoute.page,
        ),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authBloc = GetIt.I<AuthBloc>();

    // Проверяем текущее состояние авторизации
    final currentState = authBloc.state;
    if (currentState is Authenticated) {
      resolver.next(); // Продолжаем навигацию без анимации
    } else {
      authBloc.add(AuthCheckRequested());

      // Подписываемся на изменения состояния
      authBloc.stream
          .firstWhere(
              (state) => state is Authenticated || state is Unauthenticated)
          .then((state) {
        if (state is Authenticated) {
          resolver.next();
        } else {
          router.replace(const SignInRoute());
        }
      });
    }
  }
}
