import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Models/auth_exception.dart';
import 'package:todo_app_route/Ui/Screens/verified_email_screen.dart';

import '../../Core/Firebase/firebase_auth_function.dart';
import '../../Shared/Components/default_btn.dart';
import '../../Shared/Components/text_form_field_component.dart';
import '../../Shared/Themes/app_theme.dart';
import '../../Shared/validated_login_function.dart';
import 'authentication_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isShow = true;
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void dispose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .03),
            child: Image.asset(
              "assets/images/splash.png",
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .07,
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.createAccountBtn,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
              SizedBox(
                height: height * .038,
              ),
              Text(
                AppLocalizations.of(context)!.introductoryLetterRegister,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColorLight,
                    ),
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
                validator: (value) => ValidatedLoginFunction.validateEmail(
                    value, AppLocalizations.of(context)!.emailError),
              ),
              SizedBox(
                height: height * .038,
              ),
              CustomTextFormField(
                controller: passwordTextEditingController,
                labelText: AppLocalizations.of(context)!.password,
                validator: (value) => ValidatedLoginFunction.validatePassword(
                    value, AppLocalizations.of(context)!.passwordError),
                obscureText: isShow,
                suffixIcon: isShow ? Icons.visibility_off : Icons.visibility,
                suffixIconOnPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
              ),
              SizedBox(
                height: height * .08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loginTxt,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .03,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DefaultBtn(
                      title: AppLocalizations.of(context)!.createAccountBtn,
                      isShow: true,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          signUp();
                        }
                      },
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

  Future<void> signUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuthFunction.createUserWithEmailAndPassword(
        name: nameTextEditingController.text,
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      ).then((user) {
        if (!mounted) return;
        Provider.of<AuthenticationProvider>(context, listen: false)
            .updateUser(user);
        Navigator.pushReplacementNamed(
          context,
          VerifiedEmailScreen.routeName,
          arguments: emailTextEditingController.text,
        );
      });
    } on ServerException catch (e) {
      setState(() {
        isLoading = false;
      });
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
