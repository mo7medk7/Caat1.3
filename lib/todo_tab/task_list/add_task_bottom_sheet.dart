import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../firebase_utils.dart';
import '../../model/task.dart';
import '../../my_theme.dart';
import '../../providers/app_config_provider.dart';
import '../../providers/list_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  var formKey = GlobalKey<FormState>();

  // String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
  String title = '';
  String description = '';
  String emUsername = '';
  List<String> emails = []; // Store fetched emails
  String? selectedEmail; // Store selected email

  late AppConfigProvider provider;
  late ListProvider Listprovider;

  @override
  void initState() {
    super.initState();
    fetchUserEmails(); // Fetch emails from Firestore when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    Listprovider = Provider.of<ListProvider>(context);
    return Container(
      color: provider.isDarkMode()
          ? Theme.of(context).primaryColor
          : MyTheme.whiteColor,
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.addnewtask,
                style: Theme.of(context).textTheme.titleMedium),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(style:  TextStyle(color:  provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseentertasktitle;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText:
                                (AppLocalizations.of(context)!.entertasktitle),
                            hintStyle: Theme.of(context).textTheme.titleMedium),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(style:  TextStyle(color:  provider.isDarkMode()?MyTheme.whiteColor:MyTheme.greyColor),
                        onChanged: (text) {
                          description = text;
                        },
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
                            hintStyle: Theme.of(context).textTheme.titleMedium),
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.selectdate,
                          style: Theme.of(context).textTheme.titleSmall),
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
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedEmail,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedEmail = newValue;
                          });
                        },
                        items: emails.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: 'Select an email',
                          hintStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyTheme.primaryLightColor)),
                        onPressed: () {
                          //  add task to firebase
                          addTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 22),
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() async {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
          dateTime: selectedDate,
          title: title,
          description: description,
          employeeEmail: selectedEmail,
      );
      FirebaseUtils.addTaskToFirebase(task).timeout(Duration(milliseconds: 500),
          onTimeout: () {
        print('todo added successfully');
        Listprovider.getAllTasksFromFireStore(context);
        Navigator.pop(context);
        showToastMessage("todo added successfully");
      });
    }
  }

  void showToastMessage(String message) => Fluttertoast.showToast(
      msg: message,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: MyTheme.yelloColor,
      textColor: MyTheme.blackColor);


  Future<void> fetchUserEmails() async {
    try {
      // Query Firestore collection 'users' to fetch user emails
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      List<String> userEmails = querySnapshot.docs.map((doc) => doc['email'] as String).toList();

      setState(() {
        emails = userEmails;
      });
    } catch (e) {
      print("Error fetching user emails: $e");
    }
  }
}
