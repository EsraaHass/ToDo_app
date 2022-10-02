import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/view/shared/my_theme.dart';

class ShowModelSheetTheme extends StatefulWidget {
  @override
  State<ShowModelSheetTheme> createState() => _ShowModelSheetThemeState();
}

class _ShowModelSheetThemeState extends State<ShowModelSheetTheme> {
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      color: provider.isDark()
          ? MyTheme.darkscaffoldBackGroundColor
          : Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.isDark()
                ? getUnSelectedTheme(AppLocalizations.of(context)!.light)
                : getSelectedTheme(AppLocalizations.of(context)!.light),
          ),
          InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.isDark()
                  ? getSelectedTheme(AppLocalizations.of(context)!.dark)
                  : getUnSelectedTheme(AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }

  Widget getSelectedTheme(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: const Color(0xFFBFD1E0),
          border: Border.all(color: MyTheme.lightPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black),
          ),
          const Icon(
            Icons.check,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget getUnSelectedTheme(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: MyTheme.lightPrimary)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Icon(
            Icons.check,
            size: 25,
            color: MyTheme.lightPrimary,
          )
        ],
      ),
    );
  }
}
