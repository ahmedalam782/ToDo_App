import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_route/Core/Firebase/firebase_auth_function.dart';
import 'package:todo_app_route/Models/auth_exception.dart';

import '../../Shared/Components/default_btn.dart';
import '../../Shared/Components/text_form_field_component.dart';
import '../../Shared/Themes/app_theme.dart';
import '../../Shared/validated_login_function.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailEditingController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * .12,
          vertical: MediaQuery.sizeOf(context).height * .04,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .038,
              ),
              CustomTextFormField(
                controller: emailEditingController,
                keyboardType: TextInputType.text,
                labelText: AppLocalizations.of(context)!.email,
                validator: (value) => ValidatedLoginFunction.validateEmail(
                  value!.trim(),
                  AppLocalizations.of(context)!.emailError,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .038,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: DefaultBtn(
                          title: AppLocalizations.of(context)!.submit,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              try {
                                sendEmailToResetPassword();
                              } catch (e) {}
                            }
                          }),
                    ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .038,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendEmailToResetPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuthFunction.sendPasswordResetEmail(
        email: emailEditingController.text,
      );
      if (!mounted) return;
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.resetPasswordMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.white,
        textColor: AppTheme.black,
        fontSize: 18.0,
      );
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
