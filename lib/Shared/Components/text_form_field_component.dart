import 'package:flutter/material.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function()? suffixIconOnPressed;
  final bool obscureText;
  final IconData? suffixIcon;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.suffixIconOnPressed,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      cursorColor: Theme.of(context).primaryColor,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.grey,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        hoverColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.titleMedium,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          onPressed: suffixIconOnPressed,
          icon: Icon(
            suffixIcon,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    );
  }
}
