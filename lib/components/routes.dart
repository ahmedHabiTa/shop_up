import 'package:flutter/material.dart';
import 'package:shop_up/screens/login/login_screen.dart';
import 'package:shop_up/screens/shop_screens/cart/cart_screen.dart';
import 'package:shop_up/screens/shop_screens/categories/categories_screen.dart';
import 'package:shop_up/screens/shop_screens/home/home_screen.dart';
import 'package:shop_up/screens/shop_screens/search/search_screen.dart';
import 'package:shop_up/screens/sign_up/sign_up_screen.dart';
import 'file:///C:/Users/Ahmed/AndroidStudioProjects/shop_up/lib/screens/on_boarding_screen.dart';
import 'package:shop_up/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  Login.routeName: (context) => Login(),
  SignUp.routeName: (context) => SignUp(),
  HomePage.routeName: (context) => HomePage(),
  SearchScreen.routeName: (context) => SearchScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  Categories.routeName: (context) => Categories(),

};


