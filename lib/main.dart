import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Core/Firebase/firebase_auth_function.dart';
import 'package:todo_app_route/Models/auth_model.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';
import 'package:todo_app_route/Shared/network/local/cache_helper.dart';
import 'package:todo_app_route/Ui/Screens/authentication_provider.dart';
import 'package:todo_app_route/Ui/Screens/home_screen.dart';
import 'package:todo_app_route/Ui/Screens/login_screen.dart';
import 'package:todo_app_route/Ui/Screens/register_screen.dart';
import 'package:todo_app_route/Ui/Screens/splash_screen.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/setting_provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/Edit%20Tasks/edit_task.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

import 'Ui/Screens/verified_email_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  final id = await CacheHelper.getData(
        key: "userId",
      ) ??
      "";
  final AuthModel? user;
  if (id != "") {
    user = await FirebaseAuthFunction.getUserFromFirebase(id);
  } else {
    user = null;
  }
  ThemeMode theme = await CacheHelper.getData(key: 'isDark') == null
      ? ThemeMode.light
      : CacheHelper.getData(key: 'isDark')
          ? ThemeMode.dark
          : ThemeMode.light;
  String lang = await CacheHelper.getData(key: 'isLanguage') ?? "en";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider()..updateUser(user),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingProvider()
            ..changeLanguage(lang)
            ..changeThemeMode(theme),
        ),
        ChangeNotifierProvider(
          create: (_) => TasksProvider(),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        VerifiedEmailScreen.routeName: (_) => const VerifiedEmailScreen(),
        EditTask.routeName: (_) => const EditTask(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.lang),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingProvider.themeMode,
    );
  }
}
