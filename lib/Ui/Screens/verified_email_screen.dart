import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Shared/Components/default_btn.dart';

class VerifiedEmailScreen extends StatelessWidget {
  static const String routeName = "VerifiedEmailScreen";

  const VerifiedEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
            SizedBox(
              height: height * .01,
            ),
            Text(
              AppLocalizations.of(context)!.checkInbox,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).primaryColorLight),
            ),
            SizedBox(
              height: height * .038,
            ),
            Text(
              AppLocalizations.of(context)!.activationEmail,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 14,
                  ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Text(
              email,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 18,
                  ),
            ),
            SizedBox(
              height: height * .09,
            ),
            DefaultBtn(
              title: AppLocalizations.of(context)!.login,
              isShow: false,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
