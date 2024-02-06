import 'package:caatsec/todo_tab/task_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_theme.dart';

class ToDoTab extends StatelessWidget {
  static const String routeName = "ToDoTab";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context , index){
        return TaskWidget();
      }),
    );
  }
}
