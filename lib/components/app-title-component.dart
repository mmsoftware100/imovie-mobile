import 'package:flutter/material.dart';
import 'package:imovie/data/const-data.dart';

class AppTitleComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _appTitle();
  }

  Widget _appTitle(){
      return Text(appName);
  }
}
