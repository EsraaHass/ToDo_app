import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/Presentation_layer/my_theme.dart';
import 'package:todo/stateManageMent_layer/provider.dart';

class ShowModelSheetLanguage extends StatefulWidget {
  @override
  State<ShowModelSheetLanguage> createState() => _ShowModelSheetLanguageState();
}

class _ShowModelSheetLanguageState extends State<ShowModelSheetLanguage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      color: provider.isDark()
          ? MyTheme.darkscaffoldBackGroundColor
          : Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /////////AppLocalizations.of(context)!.english
          InkWell(
            onTap: () {
              provider.changeLang('en');
            },
            child: provider.isEnglish()
                ? getSelectedLanguage(AppLocalizations.of(context)!.english)
                : getUnSelectedLanguage(AppLocalizations.of(context)!.english),
          ),
          InkWell(
            onTap: () {
              provider.changeLang('ar');
            },
            child: provider.isEnglish()
                ? getUnSelectedLanguage(AppLocalizations.of(context)!.arabic)
                : getSelectedLanguage(AppLocalizations.of(context)!.arabic),
          )
        ],
      ),
    );
  }

  Widget getSelectedLanguage(String text) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: provider.isDark() ? Colors.black : Colors.white,
          border: Border.all(color: MyTheme.lightPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Icon(
            Icons.check,
            size: 25,
            color: MyTheme.lightPrimary,
          )
        ],
      ),
    );
  }

  Widget getUnSelectedLanguage(String text) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: provider.isDark() ? Colors.black : Colors.white,
          border: Border.all(color: MyTheme.lightPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Icon(
            Icons.check,
            size: 25,
            color: MyTheme.lightPrimary,
          )
        ],
      ),
    );
  }
}
