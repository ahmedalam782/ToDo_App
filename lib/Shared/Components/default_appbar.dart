import 'package:flutter/material.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({super.key, required this.title, this.isShow = false});

  final String title;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .09,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .25,
      color: AppTheme.blue,
      child: Row(
        children: [
          isShow
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width * .07,
                ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
