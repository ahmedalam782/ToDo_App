import 'package:flutter/material.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Settings_Tab/settings_tab.dart';
import 'package:todo_app_route/Ui/Widgets/Tabs/Tasks_Tab/tasks_tab.dart';

import '../Widgets/Tabs/add_task/add_tasks.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const TasksTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: "Tasks",
              icon: Icon(
                Icons.menu,
                size: 33,
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(
                Icons.settings,
                size: 33,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (buildContext) => const AddTasks(),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabs,
      ),
    );
  }
}
