
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repositories/core/theming/colors.dart';

import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  const AppTextFormField({super.key, required this.hintText, this.suffixIcon, this.obscureText, this.focusedBorder, this.enabledBorder, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding:contentPadding?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:focusedBorder?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorsManager.mainBlue,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(16.0.sp),
        ),
        enabledBorder: enabledBorder ?? OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.lightGrey,
            ),
            borderRadius: BorderRadius.circular(16.0.sp)),
        hintText: hintText,
        hintStyle: TextStyles.font14Gray,
        suffixIcon: suffixIcon,
        fillColor: ColorsManager.moreLightGrey,
        filled: true

      ),
      obscureText: obscureText ??false,

    );
  }
}
