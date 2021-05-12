import 'package:flutter/material.dart';
import 'package:shop_up/components/size.dart';
import 'package:shop_up/components/widgets/on_boarding_component.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';
import 'package:shop_up/screens/login/login_screen.dart';




class OnBoardingScreen extends StatefulWidget {
  static String routeName = "/onBoarding";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;
  var controller = PageController();
  int isLast = 0 ;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to OrderTECH , Let\'s shop",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help people connect with stores \naround the World",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: PageView.builder(
                      physics: BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        setState((){
                          currentPageIndex = index;
                        });
                      },
                      itemCount: splashData.length,
                      itemBuilder: (context, index) {
                        return OnBoardingContent(
                          text: splashData[index]['text'],
                          image: splashData[index]['image'],
                        );
                      },
                    )),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: List.generate(splashData.length,
                              (index) => buildDot(index: index)),
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth*0.5,
                          height: getProportionateScreenHeight(56),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.deepOrange,
                            onPressed: () {
                              SharedPrefsHelper.saveData(key: 'OnBoarding', value: true).then((value){
                                if(value){
                                  Navigator.of(context).pushReplacementNamed(Login.routeName);
                                }
                              });

                            },
                            child: Text(
                              'Continue',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   buildDot({int index}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPageIndex == index ? 15 : 6,
      decoration: BoxDecoration(
        color: currentPageIndex == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
