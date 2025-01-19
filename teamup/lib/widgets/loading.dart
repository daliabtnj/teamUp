import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teamup/utils/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeData.dark().scaffoldBackgroundColor,
      child: Center(
        child: SpinKitChasingDots(
          color: brandGreen,
          size: 50.0,
        ),
      ),
    );
  }
}