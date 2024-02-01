import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

abstract class ThemeManager{
  static ThemeData getAppTheme(){
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.blackColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: ColorsManager.blackColor,
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.blackColor,
        ),
      )
    );
  }
}