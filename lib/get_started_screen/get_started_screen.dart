import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_screen.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = "get_started";

  @override
  Widget build(BuildContext context) {    var provider = Provider.of<AppConfigProvider>(context);

  return Scaffold(
        backgroundColor: provider.isDarkMode()? MyTheme.primaryDarkColor: MyTheme.primaryLightColor,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(120),
            child: Image.asset('assets/images/icon.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250, left: 90),
            child: Image.asset('assets/images/audithubicon.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Text("""       this CAAT aims to make audits more 
         efficient, accurate, and financially 
              accessible for companies.""",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MyTheme.whiteColor, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 500, left:35),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                    primary: MyTheme.yelloColor,
                    onPrimary: MyTheme.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                child: Text('Start Now',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: MyTheme.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          )
        ]));
  }
}
