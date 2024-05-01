import 'package:caatsec/todo_tab/task_list/task_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../firebase_utils.dart';
import '../../model/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/list_provider.dart';


class TaskWidget extends StatefulWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    var Listprovider = Provider.of<ListProvider>(context);
    ///   var authprovider = Provider.of<AuthhProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditTaskScreen.routeName,
            arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.30,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(15),onPressed: (context) {

                FirebaseUtils.deleteTaskFromFireStore(
                    widget.task)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  showToastMessage("todo deleted successfully");
                  print("todo deleted successfully");
                  Listprovider.getAllTasksFromFireStore();
                });
              },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: provider.isDarkMode()
                    ? MyTheme.blueTask
                    : MyTheme.blueTask),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: widget.task.isDone!
                      ? MyTheme.greenLight
                      : MyTheme.primaryLightColor,
                  height: 80,
                  width: 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenLight
                                : MyTheme.primaryLightColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(children: [
                        Text(widget.task.description ?? '',
                            style: Theme.of(context).textTheme.titleSmall),
                      ],)
                    ),
                  ],
                )),
                InkWell(
                  onTap: () {
                    widget.task.isDone = !widget.task.isDone!;
                    FirebaseUtils.editIsDone(
                        widget.task);
                    setState(() {});
                  },
                  child: widget.task.isDone!
                      ? Text(
                          "Done!",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.greenLight),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 21, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyTheme.primaryLightColor,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 35,
                            color: MyTheme.whiteColor,
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }  void showToastMessage(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: MyTheme.yelloColor,
      textColor: MyTheme.blackColor);

}
