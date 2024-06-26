import 'package:caatsec/todo_tab/task_list/add_task_bottom_sheet.dart';
import 'package:caatsec/todo_tab/task_list/task_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

import '../my_theme.dart';

import '../providers/app_config_provider.dart';

import '../providers/auth_provider.dart';
import '../providers/list_provider.dart';

class ToDoTab extends StatefulWidget {
  static const String routeName = "ToDoTab";

  @override
  State<ToDoTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<ToDoTab> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthhProvider>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    if (listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFireStore(context);
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: provider.isDarkMode() ? MyTheme.blueDarkColor : MyTheme.whiteColor,
        ),
        centerTitle: true,
        title: Text('Task', style: Theme.of(context).textTheme.titleLarge),
      ),
      backgroundColor: provider.isDarkMode() ? MyTheme.blueDarkColor : MyTheme.whiteColor,
      floatingActionButton:authProvider.isAdmin?
           FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: MyTheme.whiteColor, width: 5)),
        onPressed: () {
          AddTaskModelSheet();
        },
        child: Icon(Icons.add),
      )
          : null,
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: listProvider.selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              listProvider.setNewSelectedDate(date,context);
            },
            leftMargin: 20,
            monthColor: provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.blackColor,
            dayColor: provider.isDarkMode() ? MyTheme.whiteColor : MyTheme.blackColor,
            activeDayColor: MyTheme.whiteColor,
            activeBackgroundDayColor: MyTheme.primaryLightColor,
            dotsColor: MyTheme.whiteColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskWidget(task: listProvider.taskList[index]);
              },
              itemCount: listProvider.taskList.length,
            ),
          ),
        ],
      ),
    );
  }

  void AddTaskModelSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
