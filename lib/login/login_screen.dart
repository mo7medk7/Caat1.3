import 'package:caatsec/signup/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_form_field.dart';
import '../home_tab/home_screen.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController(text: 'mkm20200@gmail.com');

  var passwordController = TextEditingController(text: 'mkm123456789');

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        backgroundColor: provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 120, right: 120),
                child: Image.asset('assets/images/blueicon.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 100, right: 100),
                child: provider.isDarkMode()? Image.asset('assets/images/helloiconwhite.png'): Image.asset('assets/images/helloicon.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(' Enter Your Details below',
                    style:provider.isDarkMode()?Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: MyTheme.whiteColor,
                        fontWeight: FontWeight.bold,):
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: MyTheme.greyColor,
                          fontWeight: FontWeight.bold,
                        )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      CustomTextFormField(
                        textIcon: CupertinoIcons.envelope_fill,
                        controller: emailController,
                        hintText: 'Email Address',
                        labelText: 'Email Address',
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter email address";
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return "please enter valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CustomTextFormField(
                        textIcon: CupertinoIcons.padlock_solid,
                        controller: passwordController,
                        hintText: 'password',
                        labelText: 'password',
                        obscureText: true,
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please enter password";
                          }
                          if (text.length < 6) {
                            return "password should be at least 6 chars";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () {
                            login();
                          },
                          child: Text('LOG IN',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: MyTheme.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' Don’t Have Account?',
                              style: provider.isDarkMode()? Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                  color: MyTheme.whiteColor,
                                  fontWeight: FontWeight.bold,)
                                  : Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: MyTheme.greyColor,
                                    fontWeight: FontWeight.bold,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignUPScreen.routeName);
                              },
                              child: Text(' Sign Up',
                                  style: provider.isDarkMode()? Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                      color: MyTheme.whiteColor,
                                      fontWeight: FontWeight.bold,) : Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: MyTheme.primaryDarkColor,
                                        fontWeight: FontWeight.bold,
                                      )))
                        ],
                      )
                    ],
                  )),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }catch(e){
        print(e.toString());
      }

    }
  }
}
