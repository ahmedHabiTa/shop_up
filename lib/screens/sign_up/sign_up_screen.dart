import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shop_up/components/size.dart';
import 'package:shop_up/components/widgets/custom_surfix_icon.dart';
import 'package:shop_up/components/widgets/social_card.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';

import 'package:shop_up/screens/login/login_screen.dart';
import 'package:shop_up/screens/shop_screens/home/home_screen.dart';
import 'package:shop_up/screens/sign_up/bloc/cubit.dart';
import 'package:shop_up/screens/sign_up/bloc/states.dart';


class SignUp extends StatelessWidget {
  static String routeName = "/signUp";
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
         listener: (context,state){
           if (state is RegisterSuccessState) {
             if (state.loginModel.status) {
               SharedPrefsHelper.saveData(
                   key: 'token', value: state.loginModel.data.token)
                   .then((value) {
                 Navigator.pushReplacementNamed(context, HomePage.routeName);
               });
               Fluttertoast.showToast(
                   msg: state.loginModel.message,
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.green,
                   textColor: Colors.white,
                   fontSize: 16.0);
             } else {
               Fluttertoast.showToast(
                   msg: state.loginModel.message,
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.red,
                   textColor: Colors.white,
                   fontSize: 16.0);
             }
           }
         },
         builder: (context,state){
           return Scaffold(
               body: SafeArea(
                 child: Container(
                   height: SizeConfig.screenHeight,
                   decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [Colors.grey, Colors.blueAccent],
                       )),
                   child: SizedBox(
                     width: double.infinity,
                     child: Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: getProportionateScreenWidth(20)),
                       child: SingleChildScrollView(
                         child: Column(
                           children: [
                             SizedBox(height: 20),
                             Text(
                               "Register Account",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontSize: getProportionateScreenWidth(28),
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Text(
                               "Complete your details or \n continue with your Social Accounts",
                               textAlign: TextAlign.center,
                               style: TextStyle(color: Colors.black54),
                             ),
                             SizedBox(height: 20),
                             Form(
                               key: formKey,
                               child: Column(
                                 children: [
                                   TextFormField(
                                     decoration: InputDecoration(
                                         labelText: "Name",
                                         hintText: "Enter your Name",
                                         floatingLabelBehavior:
                                         FloatingLabelBehavior.always,
                                         suffixIcon: CustomSuffixIcon(
                                           svgIcon: 'assets/icons/User.svg',
                                         )),
                                     keyboardType: TextInputType.text,
                                     controller: nameController,
                                   ),
                                   SizedBox(
                                     height: getProportionateScreenHeight(20),
                                   ),
                                   TextFormField(
                                     decoration: InputDecoration(
                                         labelText: "E-mail",
                                         hintText: "Enter your Email",
                                         floatingLabelBehavior:
                                         FloatingLabelBehavior.always,
                                         suffixIcon: CustomSuffixIcon(
                                           svgIcon: 'assets/icons/Mail.svg',
                                         )),
                                     keyboardType: TextInputType.emailAddress,
                                     controller: emailController,
                                   ),
                                   SizedBox(
                                     height: getProportionateScreenHeight(20),
                                   ),

                                   TextFormField(
                                     decoration: InputDecoration(
                                         labelText: "Phone Number",
                                         hintText: "Enter your Phone number",
                                         floatingLabelBehavior:
                                         FloatingLabelBehavior.always,
                                         suffixIcon: CustomSuffixIcon(
                                           svgIcon: 'assets/icons/Phone.svg',
                                         )),
                                     keyboardType: TextInputType.number,
                                     controller: phoneNumberController,
                                   ),
                                   SizedBox(
                                     height: getProportionateScreenHeight(20),
                                   ),
                                   TextFormField(
                                     decoration: InputDecoration(
                                         labelText: "Password",
                                         hintText: "Enter your Password",
                                         floatingLabelBehavior:
                                         FloatingLabelBehavior.always,
                                         suffixIcon: CustomSuffixIcon(
                                           svgIcon: 'assets/icons/Lock.svg',
                                         )),
                                     keyboardType: TextInputType.emailAddress,
                                    controller: passwordController,
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(
                               height: getProportionateScreenHeight(20),
                             ),
                             Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   gradient: LinearGradient(
                                       colors: [Colors.black26, Colors.blue[800]])),
                               width: getProportionateScreenWidth(200),
                               height: getProportionateScreenHeight(50),
                               child: SizedBox(
                                 width: double.infinity,
                                 height: getProportionateScreenHeight(56),
                                 child: state != RegisterLoadingState() ? FlatButton(
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20)),
                                   onPressed: () {
                                     if (formKey.currentState.validate()) {
                                       RegisterCubit.get(context).userRegister(
                                           name: nameController.text,
                                           email: emailController.text,
                                           phone: phoneNumberController.text,
                                           password: passwordController.text);
                                     }
                                   },
                                   child: Text(
                                     "Register",
                                     style: TextStyle(
                                       fontSize: getProportionateScreenWidth(18),
                                       color: Colors.white,
                                     ),
                                   ),
                                 ) : Center(child: CircularProgressIndicator(),)
                               ),
                             ),
                             SizedBox(height: 10),
                             Center(
                               child: Text(
                                 "-------- OR ---------",
                                 style: TextStyle(color: Colors.black54, fontSize: 17),
                               ),
                             ),
                             SizedBox(height: 10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 SocialCard(
                                   icon: "assets/icons/google-icon.svg",
                                   press: () {},
                                 ),
                                 SocialCard(
                                   icon: "assets/icons/facebook-2.svg",
                                   press: () {},
                                 ),
                                 SocialCard(
                                   icon: "assets/icons/twitter.svg",
                                   press: () {},
                                 ),
                               ],
                             ),
                             SizedBox(height: 10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   'already have an account ?',
                                   style: GoogleFonts.robotoCondensed(
                                       textStyle: TextStyle(
                                           fontSize: getProportionateScreenWidth(16),
                                           color: Colors.black)),
                                 ),
                                 Container(
                                   height: 25,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                       gradient: LinearGradient(
                                           colors: [Colors.black26, Colors.blue[900]])),
                                   child: FlatButton(
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(20)),
                                     child: Text(
                                       'Login',
                                       style: GoogleFonts.robotoCondensed(
                                           textStyle: TextStyle(
                                               fontSize: getProportionateScreenWidth(16),
                                               color: Colors.white)),
                                     ),
                                     onPressed: () {
                                       Navigator.of(context).pushNamed(Login.routeName);
                                     },
                                   ),
                                 )
                               ],
                             ),
                             Text(
                               "-By continuing your confirm that you agree with our Term and Condition",
                               style: TextStyle(
                                   color: Colors.black54,
                                   decoration: TextDecoration.underline),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ));
         },
      ),
    );
  }
}
