import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/setting_provider.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({super.key, required this.title, this.isShow = false});

  final String title;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .09,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .25,
      color: AppTheme.blue,
      child: Row(
        children: [
          isShow
              ? Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: settingProvider.lang == 'en'
                        ? MediaQuery.of(context).size.width * .04
                        : 0,
                    start: settingProvider.lang == 'ar'
                        ? MediaQuery.of(context).size.width * .06
                        : 0,
                  ),
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * .07,
                ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
