import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Models/tasks_model.dart';
import 'package:todo_app_route/Shared/Themes/app_theme.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/Edit%20Tasks/edit_task.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

class TaskDesign extends StatefulWidget {
  const TaskDesign({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskDesign> createState() => _TaskDesignState();
}

class _TaskDesignState extends State<TaskDesign> {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * .04,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              spacing: 10,
              onPressed: (_) {
                tasksProvider.deleteTask(widget.taskModel.id);
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
            SlidableAction(
              spacing: 10,
              borderRadius: BorderRadius.circular(15),
              onPressed: (_) {
                Navigator.pushNamed(context, EditTask.routeName,
                    arguments: widget.taskModel);
              },
              backgroundColor: AppTheme.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * .025,
          ),
          child: Container(
            height: MediaQuery.sizeOf(context).height * .16,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * .001,
              horizontal: MediaQuery.sizeOf(context).width * .05,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    indent: MediaQuery.sizeOf(context).height * .025,
                    color: widget.taskModel.isDone
                        ? AppTheme.green
                        : AppTheme.blue,
                    thickness: 2.5,
                    endIndent: MediaQuery.sizeOf(context).height * .025,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .02,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.taskModel.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: widget.taskModel.isDone
                                      ? AppTheme.green
                                      : Theme.of(context).primaryColor,
                                  fontSize: 18),
                        ),
                        Text(
                          widget.taskModel.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      widget.taskModel.isDone = !widget.taskModel.isDone;
                      setState(() {});
                      tasksProvider.updateTaskToDone(widget.taskModel);
                    },
                    child: widget.taskModel.isDone
                        ? Text(
                            "Done !",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: AppTheme.green,
                                ),
                          )
                        : Container(
                            height: MediaQuery.sizeOf(context).height * .054,
                            width: MediaQuery.sizeOf(context).width * .17,
                            decoration: BoxDecoration(
                              color: widget.taskModel.isDone
                                  ? AppTheme.green
                                  : AppTheme.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.check_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
