
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imovie/style/colors.dart';

class BlurredContainerUpdate extends StatelessWidget {
  final Widget child;

  BlurredContainerUpdate({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0)
        ),
        child: BackdropFilter(
          //filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)
              ),
              color: bottomNavigationBarColor.withOpacity(0.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
