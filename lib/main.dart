import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_up/components/routes.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';
import 'package:shop_up/network/remote/dio_helper.dart';

import 'package:shop_up/screens/login/login_screen.dart';
import 'package:shop_up/screens/shop_screens/home/bloc/cubit.dart';
import 'package:shop_up/screens/shop_screens/home/home_screen.dart';
import 'components/theme.dart';

import 'package:shop_up/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedPrefsHelper.init();
  Widget firstScreen;
  bool onBoarding = SharedPrefsHelper.getData(key: 'OnBoarding');
   String token =  SharedPrefsHelper.getData(key:'tok');
  if (onBoarding != null) {
    if (token != null)
      firstScreen = HomePage();
    else
      firstScreen = Login();
  } else {
    firstScreen = Splash();
  }
  runApp(MyApp(
    firstScreen: firstScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget firstScreen;
  MyApp({this.firstScreen});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getHomeData()..getCategories()..getFavourites()..getCarts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: firstScreen,
        theme: theme(),
        routes: routes,
      ),
    );
  }
}
