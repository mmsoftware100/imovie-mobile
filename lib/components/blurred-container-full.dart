
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imovie/style/colors.dart';

class BlurredContainerFull extends StatelessWidget {
  final Widget child;

  BlurredContainerFull({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(00),
        child: BackdropFilter(
          //filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: bottomNavigationBarColor.withOpacity(0.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
