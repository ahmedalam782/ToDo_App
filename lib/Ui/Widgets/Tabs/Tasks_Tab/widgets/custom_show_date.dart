import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_provider.dart';

import '../../../../Screens/authentication_provider.dart';

class CustomShowDate extends StatelessWidget {
  const CustomShowDate({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return EasyInfiniteDateTimeLine(
      physics: const BouncingScrollPhysics(),
      dayProps: EasyDayProps(
        height: MediaQuery.of(context).size.height * .12,
        inactiveDayStyle: DayStyle(
          dayNumStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          dayStrStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          monthStrStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(color: Colors.blue, width: 2),
          ),
        ),
        dayStructure: DayStructure.dayStrDayNumMonth,
        todayStyle: DayStyle(
          dayNumStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          dayStrStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          monthStrStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(color: Colors.blue, width: 2),
          ),
        ),
        activeDayStyle: DayStyle(
          dayNumStyle:
              Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          dayStrStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 15,
              ),
          monthStrStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 15,
              ),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orangeAccent,
                Colors.orange,
              ],
            ),
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      ),
      locale: AppLocalizations.of(context)!.locale,
      showTimelineHeader: false,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      focusDate: tasksProvider.selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 30)),
      onDateChange: (date) {
        tasksProvider.changeSelectDate(
          date,
          Provider.of<AuthenticationProvider>(context, listen: false)
              .currentUser!
              .id,
        );
      },
    );
  }
}
