import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/widgets/custom_show_date.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/widgets/task_design.dart';

import '../../../../Shared/Components/default_appbar.dart';
import '../../../Screens/authentication_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;

/*  final ScrollController _scrollController = ScrollController();
  bool _showDate = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          _showDate = false;
        });
      } else {
        setState(() {
          _showDate = true;
        });
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

 */

/*  final ScrollController _scrollController = ScrollController();
  bool _showDate = true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          _showDate = false;
        });
      } else {
        setState(() {
          _showDate = true;
        });
      }
    });
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

 */
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTasks) {
      final uid = Provider.of<AuthenticationProvider>(context, listen: false)
          .currentUser!
          .id;
      tasksProvider.getTasks(uid);
      shouldGetTasks = false;
    }
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            DefaultAppbar(
              title: AppLocalizations.of(context)!.toDoList,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .17,
              left: 0,
              right: 0,
              child: const CustomShowDate(),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .05,
        ),
        tasksProvider.tasks.isEmpty
            ? Expanded(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.taskNotFoundMessage,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                        ),
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasksProvider.tasks.length,
                  // controller: _scrollController,
                  itemBuilder: (_, index) => Directionality(
                    textDirection: TextDirection.ltr,
                    child: TaskDesign(
                      taskModel: tasksProvider.tasks[index],
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
