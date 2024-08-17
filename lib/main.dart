import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';
import 'package:todo_app_route/Shared/network/local/cache_helper.dart';
import 'package:todo_app_route/Ui/Screens/home_screen.dart';
import 'package:todo_app_route/Ui/Screens/login_screen.dart';
import 'package:todo_app_route/Ui/Screens/register_screen.dart';
import 'package:todo_app_route/Ui/Screens/splash_screen.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/setting_provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/Edit%20Tasks/edit_task.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TasksProvider()..getTasks(),
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
        EditTask.routeName: (_) => const EditTask(),
      },
      // initialRoute: LoginScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.lang),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingProvider.themeMode,
    );
  }
}
