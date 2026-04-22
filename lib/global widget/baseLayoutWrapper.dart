import 'package:flutter/material.dart';
import 'package:project/global%20widget/footer.dart';
import 'package:project/global%20widget/personalData.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width >= tabletBreakpoint) {
          return _desktopWrapper(desktop);
        } else if (width >= mobileBreakpoint) {
          return tablet ?? mobile; // fallback
        } else {
          return mobile;
        }
      },
    );
  }

  Widget _desktopWrapper(Widget child) {
    return child;
  }
}
