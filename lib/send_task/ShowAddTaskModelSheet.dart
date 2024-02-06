import 'package:caatsec/my_theme.dart';
import 'package:flutter/material.dart';


class ShowAddTaskModelSheet extends StatefulWidget {
  @override
  State<ShowAddTaskModelSheet> createState() => _ShowAddTaskModelSheetState();
}

class _ShowAddTaskModelSheetState extends State<ShowAddTaskModelSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = ' ';
  String description = ' ' ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text("Add New Task", style: Theme.of(context).textTheme.titleMedium),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "please input Task Title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Enter Task Title",
                        style: Theme.of(context).textTheme.titleSmall,
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please input Task Description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                        "Enter Task Description",
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 6,
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Date",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.blueColor
                        ),
                          onPressed: () {

                          },
                          child: Text('Add'),))
                ],
              ))
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }
  }



