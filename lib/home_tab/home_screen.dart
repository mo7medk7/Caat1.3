import 'package:caatsec/settings/settings_tab.dart';
import 'package:caatsec/todo_tab/to_do_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../about_us_tab/aboutus_tab.dart';
import '../contact_us_tab/contactus_tab.dart';
import '../providers/app_config_provider.dart';

import 'home_drawer.dart';
import 'home_tab.dart';
import '../login/login_screen.dart';
import '../my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: provider.isDarkMode()
                  ? MyTheme.blueDarkColor
                  : MyTheme.whiteColor),
          centerTitle: true,
          title:
              Text('AUDITHUB', style: Theme.of(context).textTheme.titleLarge),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                icon: Icon(Icons.logout,
                    color: provider.isDarkMode()
                        ? MyTheme.blueDarkColor
                        : MyTheme.whiteColor))
          ],
        ),
        drawer: Drawer(
          backgroundColor: provider.isDarkMode()
              ? MyTheme.primaryDarkColor
              : MyTheme.whiteColor,
          child: HomeDrawer(
            onSideMenuItem: onSideMenuItem,
          ),
        ),
        body: selectedMenuItem == HomeDrawer.settings
            ? SettingsTab()
            : selectedMenuItem == HomeDrawer.ToDo
                ? ToDoTab()
                : selectedMenuItem == HomeDrawer.AboutUs
                    ? AboutUsTab()
                    : selectedMenuItem == HomeDrawer.ContactUs
                        ? ContactUsTab()
                        : HomeTab());
  }

  int selectedMenuItem = HomeDrawer.home;
  void onSideMenuItem(int SelectedMenuItem) {
    selectedMenuItem = SelectedMenuItem;
    Navigator.pop(context);
    setState(() {});
  }
}
