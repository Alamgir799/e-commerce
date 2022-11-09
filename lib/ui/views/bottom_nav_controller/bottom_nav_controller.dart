// ignore_for_file: prefer_const_constructors
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/const/app_string.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller/card_screen.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller/favourite_screen.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller/home_screen.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavControllerScreen extends StatelessWidget {
  NavControllerScreen({Key? key}) : super(key: key);

  final _pages = [
    HomeScreen(),
    FavoutiteScreen(),
    CardScreen(),
    ProfileScreen(),
  ];
  RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.ecommerce,
              style: TextStyle(color: Colors.black, fontSize: 35.sp),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.deep_orange,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25.w,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 25.w,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business_center_outlined,
                    size: 25.w,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 25.w,
                  ),
                  label: ""),
            ],
            currentIndex: _currentIndex.value.toInt(),
            onTap: (int index) {
              _currentIndex.value = index;
            },
          ),
          body: _pages[_currentIndex.value.toInt()],
        ));
  }
}
