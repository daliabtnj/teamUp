import 'package:flutter/material.dart';
import 'package:teamup/utils/dimensions.dart';

// This is for if we ever decide to have a different layout for web and mobile in case we also make it for web

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web screen
          return webScreenLayout;
        }
        // else, mobile screen
        return mobileScreenLayout;
      }
    );
  }
}
