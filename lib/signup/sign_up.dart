import 'package:caatsec/signup/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_text_form_field.dart';
import '../home_tab/home_screen.dart';
import '../login/login_screen.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

class SignUPScreen extends StatefulWidget {
  static const String routeName = 'Sign Up';

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  var formKey = GlobalKey<FormState>();
  var confermationPasswordController = TextEditingController();
  var emailController = TextEditingController(text: 'caat@gmail.com');
  var nameController = TextEditingController();
  var companyController = TextEditingController();
  var passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        backgroundColor: provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.whiteColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top:50,left: 120, right: 120),
              child: Image.asset('assets/images/blueicon.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top:20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    CustomTextFormField(
                      textIcon: CupertinoIcons.person_fill   ,
                      controller: nameController,
                      hintText: 'User Name',
                      labelText: 'User Name',
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter user name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextFormField(
                      textIcon: CupertinoIcons.building_2_fill,
                      controller: companyController,
                      hintText: 'Company',
                      labelText: 'Company',
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "please enter your Company Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
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
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CustomTextFormField(
                        textIcon: CupertinoIcons.padlock_solid,
                        controller: passwordController,
                        hintText: 'Confirm password',
                        labelText: 'Confirm password',
                        obscureText: true,
                        myValidator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "please confirm your password";
                          }
                          if (text != passwordController.text) {
                            return "password doesn't match";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width * 0.8, 50),
                            primary: MyTheme.yelloColor,
                            onPrimary: MyTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                          signUp();
                        },
                        child: Text('SIGN UP',
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
                        Text('Have Account?',
                            style:
                            provider.isDarkMode()? Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                              color: MyTheme.whiteColor,
                              fontWeight: FontWeight.bold,) : Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                              color: MyTheme.greyColor,
                              fontWeight: FontWeight.bold,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName);
                            },
                            child: Text('  Sign In',
                                style:provider.isDarkMode()? Theme.of(context)
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
          ]),
        ));
  }

  void signUp() {
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
