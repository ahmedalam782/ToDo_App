import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app_route/Shared/Components/default_btn.dart';
import 'package:todo_app_route/Ui/Screens/register_screen.dart';

import '../../Shared/Components/component_login_register_with_google_facebook.dart';
import '../../Shared/Components/text_form_field_component.dart';
import '../../Shared/validated_login_function.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isShow = false;
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.login,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .07,
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/splash.png",
                  height: height * .25,
                ),
              ),
              SizedBox(
                height: height * .038,
              ),
              Text(
                AppLocalizations.of(context)!.welcome,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
              SizedBox(
                height: height * .038,
              ),
              CustomTextFormField(
                controller: emailTextEditingController,
                labelText: AppLocalizations.of(context)!.email,
                validator: (value) =>
                    ValidatedLoginFunction.validateEmail(value, context),
              ),
              SizedBox(
                height: height * .038,
              ),
              CustomTextFormField(
                controller: passwordTextEditingController,
                labelText: AppLocalizations.of(context)!.password,
                obscureText: isShow,
                validator: (value) =>
                    ValidatedLoginFunction.validatePassword(value, context),
                suffixIcon: isShow ? Icons.visibility_off : Icons.visibility,
                suffixIconOnPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
              ),
              SizedBox(
                height: height * .06,
              ),
              DefaultBtn(
                title: AppLocalizations.of(context)!.login,
                isShow: true,
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              SizedBox(
                height: height * .04,
              ),
              BottomDesignLoginRegister(
                textDivider: AppLocalizations.of(context)!.loginToAccount,
              ),
              SizedBox(
                height: height * .02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: Text(
                  AppLocalizations.of(context)!.createAccountTxt,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).primaryColorLight,
                      ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
