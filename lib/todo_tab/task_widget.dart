import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../my_theme.dart';

class TaskWidget extends StatefulWidget {


  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {


    return Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.15,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                setState(() {

                });

              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child:
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: MyTheme.blueTask),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: MyTheme.yelloTask,
                height: 80,
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Task",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: MyTheme.blackColor,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: MyTheme.blueColor,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), color: Colors.blue),
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
