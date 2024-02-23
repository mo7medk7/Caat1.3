import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';
import 'package:provider/provider.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';

class ContactUsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) { var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor:  provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.whiteColor,
      body: ContactUs(
        dividerColor: provider.isDarkMode()? MyTheme.whiteColor:MyTheme.greyColor,
        logo: AssetImage('assets/images/icon.png'),
        email: 'Audithub.ad@gmail.com',
        companyName: 'Audit hub Team',
        phoneNumber: '+2010630627099',
        dividerThickness: 2,
        emailText: 'Audithub.ad@gmail.com',
        instagram:
            'https://www.instagram.com/fatmamahmoud6271?igsh=ejd2Z3RmMmZmbmZ0',
        facebookHandle:
            'https://www.facebook.com/profile.php?id=100041738499861',
        websiteText: 'https://audithub.com',
        phoneNumberText: '+201063062709',
        website: 'https://www.google.com/',
        githubUserName: 'fatima995246',
        linkedinURL:
            'https://www.linkedin.com/in/fatma-sayed-8a3340277?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
        tagLine: 'Flutter Developer',
        twitterHandle: '@fatmasa3773982',
        textColor:provider.isDarkMode()? MyTheme.whiteColor : MyTheme.primaryDarkColor,
        cardColor:  MyTheme.primaryLightColor ,
        companyColor:provider.isDarkMode()? MyTheme.whiteColor :  MyTheme.greyColor,
        taglineColor: provider.isDarkMode()? MyTheme.whiteColor : MyTheme.primaryDarkColor,
      ),
    );
  }
}
