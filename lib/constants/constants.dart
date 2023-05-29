import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  String userName = "username";
  String filName = "filName";
  String loginBoolValue = "login";
  String cey = "favAudio";
  String isDark = "dark";

  void snackBar(String meg, BuildContext context,dynamic color) {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 4),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height*0.8,
            right: 20,
            left: 20),
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor:color,
        content: Text(meg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  Color darkLight=  const Color(0xFF9D5919);
  Color darkDark=  const Color(0xFF653610);
  Color mainColor=const Color(0xFFAB5866);
}
