import 'package:flutter/material.dart';
import 'package:flutter_checkers/util/screen.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.setContext(context);

    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ));
  }
}
