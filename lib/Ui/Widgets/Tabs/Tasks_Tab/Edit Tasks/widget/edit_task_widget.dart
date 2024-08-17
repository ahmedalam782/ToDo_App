import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Models/tasks_model.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

import '../../../../../../Shared/Components/default_btn.dart';
import '../../../../../../Shared/Components/text_form_field_component.dart';

class EditTaskWidget extends StatefulWidget {
  const EditTaskWidget({super.key});

  @override
  State<EditTaskWidget> createState() => _EditTaskWidgetState();
}

class _EditTaskWidgetState extends State<EditTaskWidget> {
  TextEditingController titleEditingController = TextEditingController();

  TextEditingController descriptionEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   TaskModel taskModel =
    //       ModalRoute.of(context)!.settings.arguments as TaskModel;
    //   titleEditingController.text = taskModel.title;
    //   descriptionEditingController.text = taskModel.description;
    //   selectedDate = taskModel.date;
    //   setState(() {
    //
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider =
        Provider.of<TasksProvider>(context, listen: false);
    TaskModel taskModel =
        ModalRoute.of(context)!.settings.arguments as TaskModel;
    if (titleEditingController.text.isEmpty) {
      titleEditingController.text = taskModel.title;
      descriptionEditingController.text = taskModel.description;
      selectedDate = taskModel.date;
    }

    var format = DateFormat(
      "dd-MM-yyyy",
      AppLocalizations.of(context)!.locale,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * .03,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: MediaQuery.sizeOf(context).height * .79,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * .06,
            vertical: MediaQuery.sizeOf(context).height * .04,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.editTasks,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).primaryColorLight,
                        ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .038,
                ),
                CustomTextFormField(
                  controller: titleEditingController,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.taskTitle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.taskTitleError;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .038,
                ),
                CustomTextFormField(
                  controller: descriptionEditingController,
                  keyboardType: TextInputType.text,
                  hintText: AppLocalizations.of(context)!.taskDescription,
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.taskDescriptionError;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .038,
                ),
                Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: selectedDate,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      );
                      if (date != null) {
                        selectedDate = date;
                        setState(() {});
                      }
                    },
                    child: Text(
                      format.format(selectedDate),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: DefaultBtn(
                      title: AppLocalizations.of(context)!.saveChange,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          taskModel.title = titleEditingController.text;
                          taskModel.description =
                              descriptionEditingController.text;
                          taskModel.date = selectedDate;
                          tasksProvider.updateTask(
                            taskModel,
                            AppLocalizations.of(context)!.taskModified,
                          );
                          Navigator.of(context).pop();
                          titleEditingController.clear();
                          descriptionEditingController.clear();
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
      ),
    );
  }
}
