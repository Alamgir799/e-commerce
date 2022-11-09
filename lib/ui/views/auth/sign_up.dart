// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/business_logics/auth_helper.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/const/app_string.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/styles/styles.dart';
import 'package:ecommerce/ui/widgets/custome_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  RxBool _passwordVisible = false.obs;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: 25.w),
            child: Text(
              AppStrings.signUp,
              style: AppStyles.myTextStyle,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Expanded(
              child: Container(
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r)),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.welcomeBack,
                        style: AppStyles.myWelcomeTextStyle,
                      ),
                      Text(AppStrings.gleadToSee,
                          style: TextStyle(
                              fontSize: 15.sp, color: Colors.black54)),
                      SizedBox(
                        height: 50.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          autofocus: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20.w,
                              color: AppColors.deep_orange,
                            ),
                            hintText: AppStrings.alamgirGmail,
                            hintStyle: TextStyle(
                                color: Colors.black38, fontSize: 20.sp),
                            labelText: AppStrings.email,
                            labelStyle: TextStyle(
                                color: AppColors.deep_orange, fontSize: 20.sp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.r)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Obx(
                          () => TextFormField(
                            obscureText: !_passwordVisible.value,
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            autofocus: true,
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return ("Password is required for login");
                              }
                              if (!regex.hasMatch(value)) {
                                return ("Enter Valid Password(Min. 6 Character)");
                              }
                            },
                            onSaved: (value) {
                              _passwordController.text = value!;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _passwordVisible.value =
                                        !_passwordVisible.value;
                                  },
                                  icon: Icon(
                                    _passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20.w,
                                    color: AppColors.deep_orange,
                                  )),
                              prefixIcon: Icon(
                                Icons.lock,
                                size: 20.w,
                                color: AppColors.deep_orange,
                              ),
                              hintText: AppStrings.star,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 20.sp),
                              labelText: AppStrings.password,
                              labelStyle: TextStyle(
                                  color: AppColors.deep_orange,
                                  fontSize: 20.sp),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      customButton(AppStrings.signUp, () {
                        final userEmail = _emailController.text;
                        final userPass = _passwordController.text;
                        var obj = AuthHelper();
                        obj.signUp(userEmail, userPass);
                        _formKey.currentState!.validate();
                      }),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: AppStrings.yesAccount,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black38,
                                ),
                                children: [
                              TextSpan(
                                text: AppStrings.login,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.deep_orange),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.toNamed(login),
                              ),
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
