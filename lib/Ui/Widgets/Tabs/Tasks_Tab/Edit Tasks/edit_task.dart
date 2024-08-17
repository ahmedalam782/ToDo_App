import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app_route/Shared/Components/default_appbar.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/Edit%20Tasks/widget/edit_task_widget.dart';

class EditTask extends StatelessWidget {
  static const String routeName = "EditTask";

  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        const Scaffold(),
        DefaultAppbar(
          title: AppLocalizations.of(context)!.toDoList,
          isShow: true,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .17,
          right: 0,
          left: 0,
          child: const EditTaskWidget(),
        ),
      ],
    );
  }
}
