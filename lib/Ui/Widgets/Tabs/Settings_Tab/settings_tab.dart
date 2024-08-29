import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Core/Firebase/firebase_auth_function.dart';
import 'package:todo_app_route/Models/auth_exception.dart';
import 'package:todo_app_route/Ui/Screens/login_screen.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/setting_provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

import '../../../../Shared/Components/default_appbar.dart';
import '../../../../Shared/Components/default_drop_btn.dart';
import '../../../../Shared/Themes/app_theme.dart';
import '../../../../Shared/network/local/cache_helper.dart';
import '../../../Screens/authentication_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultAppbar(
            title: AppLocalizations.of(context)!.settings,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * .05,
                horizontal: MediaQuery.sizeOf(context).width * .05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14, color: Theme.of(context).primaryColorLight),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .03,
                ),
                DefaultDropBtn(
                  currentValue: settingProvider.lang,
                  firstValue: 'en',
                  secondValue: 'ar',
                  firstTitle: AppLocalizations.of(context)!.english,
                  secondTitle: AppLocalizations.of(context)!.arabic,
                  onChanged: (value) => settingProvider.changeLanguage(value!),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .03,
                ),
                Text(
                  AppLocalizations.of(context)!.mode,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).primaryColorLight,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .03,
                ),
                DefaultDropBtn(
                  currentValue: settingProvider.mode,
                  firstValue: 'light',
                  secondValue: 'dark',
                  firstTitle: AppLocalizations.of(context)!.light,
                  secondTitle: AppLocalizations.of(context)!.dark,
                  onChanged: (value) => settingProvider.changeThemeMode(
                    value == "light" ? ThemeMode.light : ThemeMode.dark,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.logout,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    IconButton(
                      onPressed: () {
                        signOut();
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 30,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuthFunction.signOut().then((_) async {
        if (!mounted) return;
        final userId =
            Provider.of<AuthenticationProvider>(context, listen: false)
                .currentUser!
                .id = "";
        Provider.of<TasksProvider>(context, listen: false).tasks.clear();
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        await FirebaseAuthFunction.authStateChanges(
          AppLocalizations.of(context)!.signInMsg,
          AppLocalizations.of(context)!.signOutMsg,
        );
        await CacheHelper.saveData(key: "userId", value: userId);
      });
    } on ServerException catch (e) {
      Fluttertoast.showToast(
        msg: e.errorModel.errorMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.white,
        textColor: AppTheme.red,
        fontSize: 18.0,
      );
    }
  }
}
