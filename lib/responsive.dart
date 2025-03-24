import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }

  static int crossAxisCount(double screenWidth) {
    if (screenWidth >= 2300) {
      return 8;
    }
    if (screenWidth >= 2000) {
      return 7;
    }
    if (screenWidth >= 1700) {
      return 6;
    }
    if (screenWidth >= 1536) {
      return 5;
    }
    if (screenWidth >= 1440) {
      return 4;
    }
    if (screenWidth >= 1024) {
      return 4;
    }

    return 4;
  }

  static double childAspectRatio(double screenWidth) {
    if (screenWidth >= 1536) {
      return 0.55;
    }
    if (screenWidth >= 1440) {
      return 0.6;
    }
    if (screenWidth >= 1024) {
      return 0.48;
    }
    return 0.48;
  }

  static int licenseCrossAxisCount(double screenWidth) {
    if (screenWidth <= 1500) {
      return 1;
    }
    return 2;
  }

  static double licenseChildAspectRatio(double screenWidth) {
    if (screenWidth <= 1500) {
      return 3.3;
    }
    return 1.8;
  }
}
