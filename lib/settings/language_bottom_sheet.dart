import 'package:caatsec/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10,),
        InkWell(onTap: () { provider.changeLanguage('en');}, child:provider.appLanguage == 'en'
            ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
            : getUnSelectedItemWidget(AppLocalizations.of(context)!.english),), SizedBox(height: 10,),
        InkWell(
          onTap: () { provider.changeLanguage('ar');},
          child:provider.appLanguage == 'ar'
              ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
              : getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
        )
      ],
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 14)),
          Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).primaryColor, fontSize: 14),
          )
        ],
      ),
    );
  }
}
