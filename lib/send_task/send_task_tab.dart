import 'package:caatsec/send_task/team_member_widget.dart';
import 'package:caatsec/todo_tab/task_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';
import 'ShowAddTaskModelSheet.dart';

class SendTaskTab extends StatefulWidget {
  static const String routeName = "SendTaskTab";

  @override
  State<SendTaskTab> createState() => _SendTaskTabState();
}

class _SendTaskTabState extends State<SendTaskTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
    shape: StadiumBorder(
    side: BorderSide(color: MyTheme.whiteColor, width: 5)),
    onPressed: () {
    AddTaskModelSheet();
    },
    child: Icon(Icons.add),
    ),
      body: Container(

        child: ListView.builder(itemBuilder: (context , int index){
          return TeamMemberWidget();
        },itemCount: 100,)
      ),
    );
  }

  void AddTaskModelSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ShowAddTaskModelSheet());
  }
}

