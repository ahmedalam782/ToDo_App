import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Core/Firebase/firebase_auth_function.dart';
import '../../Models/auth_exception.dart';
import '../../Ui/Screens/authentication_provider.dart';
import '../../Ui/Screens/home_screen.dart';
import '../Themes/app_theme.dart';
import 'default_btn.dart';

class BottomDesignLoginRegister extends StatefulWidget {
  final String textDivider;

  const BottomDesignLoginRegister({
    super.key,
    required this.textDivider,
  });

  @override
  State<BottomDesignLoginRegister> createState() =>
      _BottomDesignLoginRegisterState();
}

class _BottomDesignLoginRegisterState extends State<BottomDesignLoginRegister> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: Divider()),
            Text(
              widget.textDivider,
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
        DefaultBtn(
          title: AppLocalizations.of(context)!.google,
          isShow: true,
          iconData: Icons.g_mobiledata,
          onPressed: () => signInWithGoogle(),
        ),
        SizedBox(
          height: height * .04,
        ),
      ],
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      FirebaseAuthFunction.signInWithGoogle().then((user) async {
        if (!mounted) return;
        Provider.of<AuthenticationProvider>(context, listen: false)
            .updateUser(user);
        Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
        );
        await FirebaseAuthFunction.authStateChanges(
            AppLocalizations.of(context)!.signInMsg,
            AppLocalizations.of(context)!.signOutMsg);
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
