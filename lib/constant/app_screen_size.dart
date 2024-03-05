import 'package:flutter/material.dart';

class AppSceenSize {
  final webScreenSize = 600;
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Widget get loadingIcon => Center(child: CircularProgressIndicator());
}
