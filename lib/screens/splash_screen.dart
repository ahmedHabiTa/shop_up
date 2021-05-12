import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_up/screens/on_boarding_screen.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen(
          seconds: 4,
          gradientBackground: LinearGradient(
            colors: [Colors.black38, Colors.blueAccent],
          ),
          title: Text(
            'Welcome to OrderTECH',
        style: GoogleFonts.robotoCondensed(
          textStyle: TextStyle(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
          navigateAfterSeconds: OnBoardingScreen.routeName  ,
          useLoader: false,
    ));
  }
}


