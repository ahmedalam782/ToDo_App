import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/setting_provider.dart';

import '../../../../Shared/Components/default_appbar.dart';
import '../../../../Shared/Components/default_drop_btn.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Column(
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
                height: MediaQuery.sizeOf(context).height * .03,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
