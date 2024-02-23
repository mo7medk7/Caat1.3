import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];

  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore() async {

      QuerySnapshot<Task> querySnapshot= await  FirebaseUtils.getTasksCollection().get();
      taskList=  querySnapshot.docs.map((doc) {
        return  doc.data();
      }).toList();

    //filter task (selected date)
    taskList = taskList.where((task) {
      if (task.dateTime?.day == selectedDate.day &&
          task.dateTime?.month == selectedDate.month &&
          task.dateTime?.year == selectedDate.year &&
          task.emUsername=='fatma') {
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
  void setNewSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTasksFromFireStore();
  }


}
