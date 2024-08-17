import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'default_btn.dart';

class BottomDesignLoginRegister extends StatelessWidget {
  final String textDivider;
  final Function()? googleOnPressed;
  final Function()? facebookOnPressed;

  const BottomDesignLoginRegister({
    super.key,
    required this.textDivider,
    this.googleOnPressed,
    this.facebookOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: Divider()),
            Text(
              textDivider,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: Theme.of(context).primaryColorLight,
                  ),
            ),
            const Expanded(
              child: Divider(),
            ),
          ],
        ),
        SizedBox(
          height: height * .04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DefaultBtn(
                title: AppLocalizations.of(context)!.google,
                isShow: true,
                iconData: Icons.g_mobiledata,
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: width * .038,
            ),
            Expanded(
              child: DefaultBtn(
                title: AppLocalizations.of(context)!.facebook,
                isShow: true,
                iconData: Icons.facebook_outlined,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
