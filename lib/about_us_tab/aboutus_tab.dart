import 'package:caatsec/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';

class AboutUsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo or Icon
            Image.asset(
              'assets/images/blueicon.png',
              height: 100,
              width: 100,
            ),

            // App Information
            Text(
              'Audit Hub',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: provider.isDarkMode()? MyTheme.whiteColor: MyTheme.primaryDarkColor ),
            ),

            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 22,color: MyTheme.greyColor),
            ),

            // Brief Description
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                """ AuditHub streamlines complex information system evaluations through automated processes,  minimizing reliance on specialized personnel and reducing financial overhead. Implementing this CAAT aims to make audits more efficient, accurate, and financially accessible for companies """,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,color: provider.isDarkMode()? MyTheme.whiteColor: MyTheme.primaryDarkColor),
              ),
            ),

            // Additional Information or Credits
            // ...

          ],
        ),
      ),
    );
  }
}
