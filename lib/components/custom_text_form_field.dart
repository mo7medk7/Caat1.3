import 'package:caatsec/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final IconData textIcon;

  final Validator myValidator;
  CustomTextFormField(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      this.obscureText = false,
      required this.textIcon,
      required this.myValidator});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Container(
      width: screenWidth * 0.8,
      child: TextFormField(style:  TextStyle(color:  provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            hoverColor:
                provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            hintStyle: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.whiteColor
                    : MyTheme.greyColor),
            floatingLabelStyle: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.whiteColor
                    : MyTheme.greyColor),
            fillColor:
                provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            focusColor:
                provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.greyColor,
            helperStyle: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.whiteColor
                    : MyTheme.greyColor),
            labelStyle: TextStyle(
                color: provider.isDarkMode()
                    ? MyTheme.whiteColor
                    : MyTheme.greyColor),
            suffixIcon: Icon(
              textIcon,
              color: provider.isDarkMode()
                  ? MyTheme.whiteColor
                  : MyTheme.greyColor,
            )),
        obscureText: obscureText,
        validator: myValidator,
      ),
    );
  }
}
