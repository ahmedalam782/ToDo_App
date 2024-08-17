import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Shared/Components/component_login_register_with_google_facebook.dart';
import '../../Shared/Components/default_btn.dart';
import '../../Shared/Components/text_form_field_component.dart';
import '../../Shared/validated_login_function.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isShow = false;
  TextEditingController nameTextEditingController = TextEditingController();

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
          AppLocalizations.of(context)!.createAccountBtn,
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
              CustomTextFormField(
                controller: nameTextEditingController,
                labelText: AppLocalizations.of(context)!.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.nameError;
                  }
                  return null;
                },
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
                validator: (value) =>
                    ValidatedLoginFunction.validatePassword(value, context),
                obscureText: isShow,
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
                title: AppLocalizations.of(context)!.createAccountBtn,
                isShow: true,
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              SizedBox(
                height: height * .04,
              ),
              BottomDesignLoginRegister(
                textDivider: AppLocalizations.of(context)!.createAccountTxt,
              ),
              SizedBox(
                height: height * .02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.loginToAccount,
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
