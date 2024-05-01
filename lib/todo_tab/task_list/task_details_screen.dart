import 'package:caatsec/todo_tab/to_do_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../dialog_utlis.dart';
import '../../firebase_utils.dart';
import '../../model/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/list_provider.dart';


class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'Task_details';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var emUsenameController = TextEditingController();
  late ListProvider Listprovider;
  Task? task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      titleController.text = task?.title??'';
      descriptionController.text = task?.description??'';
      selectedDate = task!.dateTime!;
    });
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var Listprovider= Provider.of<ListProvider>(context);
    return Stack
      (
        children: [
      Scaffold(
          backgroundColor: provider.isDarkMode()
              ? MyTheme.blueDarkColor
              : MyTheme.blueTask,
          appBar: AppBar(
            iconTheme: IconThemeData(color: provider.isDarkMode()? MyTheme.blueDarkColor: MyTheme.whiteColor),
            title: Text(task?.title??'',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: provider.isDarkMode()
                        ? MyTheme.whiteColor
                        : MyTheme.whiteColor,
                    borderRadius: BorderRadius.circular(25)),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.09,
                    horizontal: MediaQuery.of(context).size.width * 0.06),
                child: Column(children: [
                  Text(AppLocalizations.of(context)!.edittask,
                      style: Theme.of(context).textTheme.titleMedium),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: titleController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseentertasktitle;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: (AppLocalizations.of(context)!
                                      .entertasktitle),
                                  hintStyle:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: descriptionController,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseentertaskdescription;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: (AppLocalizations.of(context)!
                                      .entertaskdescription),
                                  hintStyle:
                                      Theme.of(context).textTheme.titleMedium),
                              maxLines: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                //show calender
                                showCalender();
                              },
                              child: Text(
                                '${selectedDate.day}/${selectedDate.month}'
                                '/${selectedDate.year}',
                                style:provider.isDarkMode()?Theme.of(context).textTheme.titleSmall!.copyWith(color: MyTheme.blackColor): Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 60),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            MyTheme.primaryLightColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color:
                                                    MyTheme.primaryLightColor)))),
                                onPressed: () {
                                  //var args = ModalRoute.of(context)?.settings.arguments as Task;
                                  //  edit task to firebase
                                  editTask();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.savechanges,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: MyTheme.whiteColor),
                                )),
                          )
                        ],
                      )),
                ])),
          ))
    ]);
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void editTask() {
    if (formKey.currentState?.validate() == true) {
      task?.title = titleController.text;
      task?.description = descriptionController.text;
      task?.dateTime = selectedDate;
      FirebaseUtils.editTask(task!).then((value) {
        Navigator.pop(context);
        DialogUtils.showMessage(
            context, AppLocalizations.of(context)!.todoeditedsuccessfully,
            title: 'success',
            isDismissible: true,
            posActionName: AppLocalizations.of(context)!.ok, posAction: () {
          Navigator.of(context).pushReplacementNamed(ToDoTab.routeName);
        });
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        print("todo edited successfully");
        Listprovider.getAllTasksFromFireStore();
        Navigator.pop(context);
    }
   );
}
  }}
