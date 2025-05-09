import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// A utility class to simplify responsive UI building
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isDesktop, bool isTablet, bool isMobile) builder;

  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isTablet = ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
        !ResponsiveBreakpoints.of(context).largerThan(TABLET);
    final isMobile = !isDesktop && !isTablet;

    return builder(context, isDesktop, isTablet, isMobile);
  }
}

/// Extension to simplify getting responsive dimensions
extension ResponsiveDimensions on BuildContext {
  bool get isDesktop => ResponsiveBreakpoints.of(this).largerThan(TABLET);
  bool get isTablet => ResponsiveBreakpoints.of(this).largerThan(MOBILE) &&
      !ResponsiveBreakpoints.of(this).largerThan(TABLET);
  bool get isMobile => !isDesktop && !isTablet;

  double responsiveValue({required double mobile, double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) {
      return desktop;
    } else if (isTablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  EdgeInsets responsivePadding({
    required double horizontalMobile,
    required double verticalMobile,
    double? horizontalTablet,
    double? verticalTablet,
    double? horizontalDesktop,
    double? verticalDesktop,
  }) {
    return EdgeInsets.symmetric(
      horizontal: responsiveValue(
        mobile: horizontalMobile,
        tablet: horizontalTablet,
        desktop: horizontalDesktop,
      ),
      vertical: responsiveValue(
        mobile: verticalMobile,
        tablet: verticalTablet,
        desktop: verticalDesktop,
      ),
    );
  }

  TextStyle? responsiveTextStyle({
    required TextStyle? mobile,
    TextStyle? tablet,
    TextStyle? desktop,
  }) {
    if (isDesktop && desktop != null) {
      return desktop;
    } else if (isTablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}