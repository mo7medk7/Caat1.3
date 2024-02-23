import 'package:caatsec/my_theme.dart';
import 'package:caatsec/providers/list_provider.dart';
import 'package:caatsec/settings/settings_tab.dart';
import 'package:caatsec/todo_tab/task_list/task_details_screen.dart';
import 'package:caatsec/todo_tab/to_do_tab.dart';
import 'package:caatsec/signup/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:caatsec/providers/app_config_provider.dart';
import 'get_started_screen/get_started_screen.dart';
import 'home_tab/home_screen.dart';
import 'login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  final prefs = await SharedPreferences.getInstance();
  final prefsTheme = await SharedPreferences.getInstance();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(prefs, prefsTheme),
      ),
      ChangeNotifierProvider(create: (context) => ListProvider())
    ],
    child: MyApp(),
  ));

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetStartedScreen.routeName,
      routes: {
        GetStartedScreen.routeName: (context) => GetStartedScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUPScreen.routeName: (context) => SignUPScreen(),
        SettingsTab.routeName: (context) => SettingsTab(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ToDoTab.routeName: (context) => ToDoTab(),
        EditTaskScreen.routeName: (context) => EditTaskScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyTheme.lightTheme,
      locale: Locale(provider.appLanguage),
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
    );
  }
}
