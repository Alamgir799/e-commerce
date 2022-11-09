import 'package:ecommerce/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(
  String title,
  onPressed,
) {
  return Container(
    height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
    ),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      color: AppColors.deep_orange,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22.sp),
          ),
        ),
      ),
    ),
  );
}
