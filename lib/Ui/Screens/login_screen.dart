import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Shared/Components/default_btn.dart';
import 'package:todo_app_route/Ui/Screens/home_screen.dart';
import 'package:todo_app_route/Ui/Screens/register_screen.dart';
import 'package:todo_app_route/Ui/Widgets/forget_password.dart';

import '../../Core/Firebase/firebase_auth_function.dart';
import '../../Models/auth_exception.dart';
import '../../Shared/Components/component_login_register_with_google_facebook.dart';
import '../../Shared/Components/text_form_field_component.dart';
import '../../Shared/Themes/app_theme.dart';
import '../../Shared/validated_login_function.dart';
import 'authentication_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isShow = true;
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
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
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
              SizedBox(
                height: height * .038,
              ),
              Text(
                AppLocalizations.of(context)!.introductoryLetterLogin,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColorLight,
                    ),
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
                obscureText: isShow,
                validator: (value) => ValidatedLoginFunction.validatePassword(
                    value, AppLocalizations.of(context)!.passwordError),
                suffixIcon: isShow ? Icons.visibility_off : Icons.visibility,
                suffixIconOnPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
              ),
              SizedBox(
                height: height * .01,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (buildContext) => const ForgetPassword(),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.createAccountTxt,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                      emailTextEditingController.clear();
                      passwordTextEditingController.clear();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.createAccountBtn,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DefaultBtn(
                      title: AppLocalizations.of(context)!.login,
                      isShow: true,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          signIn();
                        }
                      },
                    ),
              SizedBox(
                height: height * .04,
              ),
              BottomDesignLoginRegister(
                textDivider: AppLocalizations.of(context)!.loginWith,
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

  Future<void> signIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuthFunction.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      ).then((user) async {
        if (!mounted) return;
        if (user == null) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.emailNotActivated,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppTheme.white,
            textColor: AppTheme.black,
            fontSize: 18.0,
          );
        } else {
          Provider.of<AuthenticationProvider>(context, listen: false)
              .updateUser(user);
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.routeName,
          );
          await FirebaseAuthFunction.authStateChanges(
              AppLocalizations.of(context)!.signInMsg,
              AppLocalizations.of(context)!.signOutMsg);
        }
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
