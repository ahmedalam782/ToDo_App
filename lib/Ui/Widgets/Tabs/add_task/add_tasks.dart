import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Models/tasks_model.dart';

import '../../../../Shared/Components/default_btn.dart';
import '../../../../Shared/Components/text_form_field_component.dart';
import '../../../Screens/authentication_provider.dart';
import '../Tasks_Tab/tasks_provider.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key, required this.onCancel});

  final void Function() onCancel;

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  TextEditingController titleEditingController = TextEditingController();

  TextEditingController descriptionEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    var format = DateFormat(
      "dd-MM-yyyy",
      AppLocalizations.of(context)!.locale,
    );
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * .12,
            vertical: MediaQuery.sizeOf(context).height * .04,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.addTasks,
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
                    if (value!.trim().isEmpty) {
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
                    if (value!.trim().isEmpty) {
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
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .038,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: DefaultBtn(
                          title: AppLocalizations.of(context)!.submit,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              tasksProvider.addTasks(
                                TaskModel(
                                  title: titleEditingController.text,
                                  date: selectedDate,
                                  description:
                                      descriptionEditingController.text,
                                ),
                                AppLocalizations.of(context)!.taskAdded,
                                Provider.of<AuthenticationProvider>(context,
                                        listen: false)
                                    .currentUser!
                                    .id,
                              );
                              Navigator.pop(context);
                              titleEditingController.clear();
                              descriptionEditingController.clear();
                            }
                            widget.onCancel();
                          },
                        ),
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
