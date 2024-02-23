import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../my_theme.dart';
import '../providers/app_config_provider.dart';
import 'Theme_bottom_sheet.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  static const String routeName = "setting";

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold( backgroundColor: provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.whiteColor,
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: provider.isDarkMode()
                  ? Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 14,
              )
                  : Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: provider.isDarkMode()
                        ? MyTheme.primaryDarkColor
                        : MyTheme.whiteColor,
                    border: Border.all(color: MyTheme.primaryLightColor, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(   provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14, color: MyTheme.primaryLightColor)),
                    Icon(
                      Icons.arrow_drop_down,
                      color:MyTheme.primaryLightColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: provider.isDarkMode()
                        ? MyTheme.primaryDarkColor
                        : MyTheme.whiteColor,
                    border: Border.all(color: MyTheme.primaryLightColor, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( provider.isDarkMode()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14, color: MyTheme.primaryLightColor)),
                    Icon(
                      Icons.arrow_drop_down,
                      color: MyTheme.primaryLightColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
