import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Ui/Screens/login_screen.dart';

import '../Widgets/Tabs/Settings_Tab/setting_provider.dart';
import 'authentication_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;
        if (Provider.of<AuthenticationProvider>(context, listen: false)
                .currentUser ==
            null) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(settingProvider.splashImage),
        ),
      ),
    );
  }
}
