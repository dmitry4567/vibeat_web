// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AllBeatsPage]
class AllBeatsRoute extends PageRouteInfo<void> {
  const AllBeatsRoute({List<PageRouteInfo>? children})
      : super(
          AllBeatsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllBeatsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllBeatsPage();
    },
  );
}

/// generated route for
/// [AllLicensePage]
class AllLicenseRoute extends PageRouteInfo<void> {
  const AllLicenseRoute({List<PageRouteInfo>? children})
      : super(
          AllLicenseRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllLicenseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllLicensePage();
    },
  );
}

/// generated route for
/// [AnketaPage]
class AnketaRoute extends PageRouteInfo<void> {
  const AnketaRoute({List<PageRouteInfo>? children})
      : super(
          AnketaRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnketaRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AnketaPage();
    },
  );
}

/// generated route for
/// [EditBeatPage]
class EditBeatRoute extends PageRouteInfo<EditBeatRouteArgs> {
  EditBeatRoute({
    Key? key,
    required BeatEntity beat,
    required bool isEditMode,
    List<PageRouteInfo>? children,
  }) : super(
          EditBeatRoute.name,
          args: EditBeatRouteArgs(
            key: key,
            beat: beat,
            isEditMode: isEditMode,
          ),
          initialChildren: children,
        );

  static const String name = 'EditBeatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditBeatRouteArgs>();
      return EditBeatPage(
        key: args.key,
        beat: args.beat,
        isEditMode: args.isEditMode,
      );
    },
  );
}

class EditBeatRouteArgs {
  const EditBeatRouteArgs({
    this.key,
    required this.beat,
    required this.isEditMode,
  });

  final Key? key;

  final BeatEntity beat;

  final bool isEditMode;

  @override
  String toString() {
    return 'EditBeatRouteArgs{key: $key, beat: $beat, isEditMode: $isEditMode}';
  }
}

/// generated route for
/// [EditLicensePage]
class EditLicenseRoute extends PageRouteInfo<EditLicenseRouteArgs> {
  EditLicenseRoute({
    Key? key,
    required LicenseEntity templateLicense,
    List<PageRouteInfo>? children,
  }) : super(
          EditLicenseRoute.name,
          args: EditLicenseRouteArgs(
            key: key,
            templateLicense: templateLicense,
          ),
          initialChildren: children,
        );

  static const String name = 'EditLicenseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditLicenseRouteArgs>();
      return EditLicensePage(
        key: args.key,
        templateLicense: args.templateLicense,
      );
    },
  );
}

class EditLicenseRouteArgs {
  const EditLicenseRouteArgs({
    this.key,
    required this.templateLicense,
  });

  final Key? key;

  final LicenseEntity templateLicense;

  @override
  String toString() {
    return 'EditLicenseRouteArgs{key: $key, templateLicense: $templateLicense}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignInPage2]
class SignInRoute2 extends PageRouteInfo<void> {
  const SignInRoute2({List<PageRouteInfo>? children})
      : super(
          SignInRoute2.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute2';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage2();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}
