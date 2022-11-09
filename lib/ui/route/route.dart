// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/ui/views/auth/login_screen.dart';
import 'package:ecommerce/ui/views/auth/sign_up.dart';
import 'package:ecommerce/ui/views/auth/user_data_screen.dart';
import 'package:ecommerce/ui/views/bottom_nav_controller/bottom_nav_controller.dart';
import 'package:ecommerce/ui/views/product_details_screen.dart';
import 'package:ecommerce/ui/views/search_screen.dart';
import 'package:ecommerce/ui/views/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

const String splash = '/splash-screen';
const String login = '/login-screen';
const String signUp = '/signUp-screen';
const String userData = '/userData-screen';
const String nav = '/nav-screen';
const String search = '/search-screen';
//const String product = '/product-screen';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: signUp,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: userData,
    page: () => UserDataScreen(),
  ),
  GetPage(
    name: nav,
    page: () => NavControllerScreen(),
  ),
  GetPage(
    name: search,
    page: () => SearchScreen(),
  ),
  // GetPage(
  //   name: product,
  //   page: (){
  //     ProductDetailsScreen _product = Get.arguments;
  //   return _product;
  //   }
  // ),
];
