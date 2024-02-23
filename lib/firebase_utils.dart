import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/my_users.dart';
import 'model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)) ,
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTasksCollection(); //get collection
    DocumentReference<Task> taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }
  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }
  static Future<void> editIsDone(Task task) {
    return getTasksCollection().doc(task.id).update({'isDone': task.isDone});
  }
  static Future<void> editTask(Task task) {
    return getTasksCollection().doc(task.id).update(task.toFireStore());
  }

}
