import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../firebase_utils.dart';
import '../model/task.dart';
import 'auth_provider.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();


  void getAllTasksFromFireStore(BuildContext context) async {
    var authprovider = Provider.of<AuthhProvider>(context, listen: false);
      QuerySnapshot<Task> querySnapshot= await  FirebaseUtils.getTasksCollection().get();
      taskList=  querySnapshot.docs.map((doc) {
        return  doc.data();
      }).toList();


    if (!authprovider.isAdmin) {
      taskList = taskList.where((task) => task.employeeEmail == authprovider.currentUser?.email).toList();
    }
    //filter task (selected date)
    taskList = taskList.where((task) {
      if (task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year) {
        return true;
      }
      return false;
    }).toList();


    //sorting tasks
    taskList.sort((Task task1, Task task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }
  void setNewSelectedDate(DateTime newDate,BuildContext context) {
    selectedDate = newDate;
    getAllTasksFromFireStore(context);
  }


}
