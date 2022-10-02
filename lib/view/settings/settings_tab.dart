import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/view/settings/language_model_sheet.dart';
import 'package:todo/view/settings/theme_model_sheet.dart';
import 'package:todo/view/shared/my_theme.dart';

class Settings_tab extends StatefulWidget {
  @override
  State<Settings_tab> createState() => _Settings_tabState();
}

class _Settings_tabState extends State<Settings_tab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          decoration: const BoxDecoration(
              color: MyTheme.lightPrimary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          height: MediaQuery.of(context).size.height * .2,
          width: double.infinity,
          child: Text(
            AppLocalizations.of(context)!.settings,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: provider.isDark() ? Colors.white : Colors.black),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showButtonSheetModeLanguage();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: provider.isDark() ? Colors.black : Colors.white,
                      border: Border.all(color: MyTheme.lightPrimary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isEnglish()
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: MyTheme.lightPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                        color: MyTheme.lightPrimary,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: provider.isDark() ? Colors.white : Colors.black),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showButtonSheetModeTheme();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: provider.isDark() ? Colors.black : Colors.white,
                      border: Border.all(color: MyTheme.lightPrimary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isDark()
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: MyTheme.lightPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                        color: MyTheme.lightPrimary,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void showButtonSheetModeTheme() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModelSheetTheme();
        });
  }

  void showButtonSheetModeLanguage() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ShowModelSheetLanguage();
        });
  }
}
