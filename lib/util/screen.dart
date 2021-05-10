import 'package:flutter/material.dart';

class ScreenUtil {
  static MediaQueryData _data;

  static void setContext(BuildContext context) =>
      _data = MediaQuery.of(context);

  static get width => _data.size.width;
  static get height => _data.size.height;
}
