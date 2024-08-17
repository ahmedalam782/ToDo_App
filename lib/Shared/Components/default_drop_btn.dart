import 'package:flutter/material.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';

class DefaultDropBtn extends StatelessWidget {
  const DefaultDropBtn({
    super.key,
    required this.currentValue,
    required this.firstValue,
    required this.secondValue,
    required this.firstTitle,
    required this.secondTitle,
    this.onChanged,
  });

  final String currentValue;
  final String firstValue;
  final String secondValue;
  final String firstTitle;
  final String secondTitle;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * .012,
            horizontal: MediaQuery.sizeOf(context).width * .04,
          ),
          dropdownColor: AppTheme.white,
          isDense: true,
          iconSize: 30,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).primaryColor, // Add this
          ),
          value: currentValue,
          items: [
            DropdownMenuItem(
              value: firstValue,
              child: Text(
                firstTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            DropdownMenuItem(
              value: secondValue,
              child: Text(
                secondTitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
