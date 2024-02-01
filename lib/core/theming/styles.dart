
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repositories/core/theming/colors.dart';

import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black
  );
  static TextStyle font13GrayRegular = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
      color: ColorsManager.grey
  );
  static TextStyle font13BlueSemiBold = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: ColorsManager.mainBlue
  );
  static TextStyle font13DarkBlueRegular = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.bold,
      color: Colors.black
  );
  static TextStyle font13DarkBlueMedium = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.medium,
      color: ColorsManager.mainBlue
  );
  static TextStyle font24BlueBold = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,      color: ColorsManager.mainBlue
  );
  static TextStyle font32BlueBold = TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeightHelper.bold,
      color: ColorsManager.mainBlue
  );
  static TextStyle font14Gray = TextStyle(
      fontSize: 14.sp,
      color: ColorsManager.grey,
  );
  static TextStyle font14GrayRegular = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.grey,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font14LightGreyRegular = TextStyle(
    fontSize: 14.sp,
    color: ColorsManager.neutralGray,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16WithMedium= TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.white
  );
  static TextStyle font16WithSemiBold= TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.white
  );
  static TextStyle font13BlueRegular= TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
      color: ColorsManager.mainBlue
  );
}