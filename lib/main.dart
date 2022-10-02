import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/view/register/register.dart';
import 'package:todo/view/shared/my_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    getValuesFromShared();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Register.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        Register.routeName: (_) => Register(),
      },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.currentTheme,
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  void getValuesFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    provider.changeLang(prefs.getString('lang') ?? 'ar');

    if (prefs.getString('theme') == 'light') {
      provider.changeTheme(ThemeMode.light);
    } else if (prefs.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    }
  }
}
