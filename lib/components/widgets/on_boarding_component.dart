import 'package:flutter/material.dart';
import 'package:shop_up/components/size.dart';

class OnBoardingContent extends StatelessWidget {
  final String text, image;

  const OnBoardingContent({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "OrderTECH",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(36),
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black87, fontSize: 17),
        ),
        Spacer(
          flex: 2,
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        )
      ],
    );
  }
}
