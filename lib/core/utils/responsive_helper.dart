import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 600 &&
      MediaQuery.sizeOf(context).width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1200;

  static double getResponsivePadding(BuildContext context) {
    if (isPhone(context)) return 16.0;
    if (isTablet(context)) return 32.0;
    return 64.0;
  }

  static int getGridColumnCount(BuildContext context) {
    if (isPhone(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
