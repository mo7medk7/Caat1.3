import 'package:caatsec/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';

class HomeDrawer extends StatelessWidget {
  Function onSideMenuItem;
  static const int home = 1;
  static const int ToDo = 2;
  static const int settings = 3;
  static const int AboutUs = 4;
  static const int ContactUs =5;
  HomeDrawer({required this.onSideMenuItem});

  @override
  Widget build(BuildContext context) {var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: MyTheme.primaryLightColor,
            ),
            accountName: Text('fatma sayed'),
            accountEmail: Text('fatmasayed@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.jpg'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.home);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.home_outlined, color:provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Home  ',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),

          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.settings);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.settings_outlined, color: provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' Settings',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.AboutUs);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.supervisor_account_outlined,
                      color: provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' About',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              onSideMenuItem(HomeDrawer.ContactUs);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.support_agent_outlined, color: provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    ' Contact Us',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
