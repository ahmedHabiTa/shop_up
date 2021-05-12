import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_up/components/size.dart';
import 'package:shop_up/components/widgets/custom_surfix_icon.dart';
import 'package:shop_up/components/widgets/social_card.dart';
import 'package:shop_up/network/local/shared_pref_helper.dart';
import 'package:shop_up/screens/login/bloc/cubit.dart';
import 'package:shop_up/screens/login/bloc/states.dart';
import 'package:shop_up/screens/shop_screens/home/home_screen.dart';
import 'package:shop_up/screens/sign_up/sign_up_screen.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  static String routeName = "/Login";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
               SharedPrefsHelper.saveData(
                      key:'tok', value: state.loginModel.data.token)
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
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
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
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Welcome To OrderTECH",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: getProportionateScreenWidth(28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Sign in with your email and password  \nor continue with social media",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 170,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/ecommerce.png',
                          ),
                        ),
                        SizedBox(height: 15),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty) return 'enter your E-mail';
                                },
                                controller: emailController,
                              ),
                              SizedBox(
                                height: 10,
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
                                obscureText: true,
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'enter your password';
                                },
                                controller: passwordController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.black26, Colors.blue[800]])),
                          width: getProportionateScreenWidth(200),
                          height: getProportionateScreenHeight(56),
                          // ignore: deprecated_member_use
                          child: state !=LoginLoadingState() ? FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ) : Center(child: CircularProgressIndicator(),)
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Forget password ?',
                          style: TextStyle(
                              color: Colors.black54,
                              decoration: TextDecoration.underline),
                        ),
                        SizedBox(height: 15),
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
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont\'t have an account ?',
                              style: GoogleFonts.robotoCondensed(
                                  textStyle: TextStyle(
                                      fontSize: getProportionateScreenWidth(16),
                                      color: Colors.black)),
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(colors: [
                                    Colors.black26,
                                    Colors.blue[900]
                                  ])),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.robotoCondensed(
                                      textStyle: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          color: Colors.white)),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SignUp.routeName);
                                },
                              ),
                            )
                          ],
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
