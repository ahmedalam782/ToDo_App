import 'package:flutter/material.dart';

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({
    super.key,
    this.onPressed,
    required this.title,
    this.isShow = false,
    this.iconData = Icons.arrow_forward,
  });

  final VoidCallback? onPressed;
  final String title;
  final IconData iconData;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: Size(
          double.infinity,
          MediaQuery.sizeOf(context).height * .072,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).primaryColorLight,
                ),
          ),
          isShow
              ? const Spacer()
              : const SizedBox(
                  width: 0,
                ),
          isShow
              ? Icon(
                  iconData,
                  color: Theme.of(context).primaryColorLight,
                  size: 25,
                )
              : const SizedBox(
                  width: 0,
                ),
        ],
      ),
    );
  }
}
