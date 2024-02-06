import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_theme.dart';
import '../providers/app_config_provider.dart';

class customitemDashBoard extends StatelessWidget {
  Color background;
  String title;
  IconData iconData;

  customitemDashBoard(
      {required this.title, required this.iconData, required this.background});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      decoration: BoxDecoration(
          color:
          provider.isDarkMode() ? MyTheme.primaryDarkColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white)),
          const SizedBox(height: 8),
          Text(title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium)
        ],
      ),
    );
  }
}