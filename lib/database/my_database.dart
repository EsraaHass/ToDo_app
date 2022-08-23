import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/task.dart';
import 'package:todo/only_date.dart';

class MyDataBase {
  static CollectionReference<Task> getTaskesCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: (snapshot, options) {
      return Task.fromFireStore(snapshot.data()!);
    }, toFirestore: (task, options) {
      return task.toFireStore();
    });
  }

  static Future<void> addTask(Task task) {
    var taskesCollection = getTaskesCollection();
    var taskDocs =
        taskesCollection.doc(); // create new document with auto id in firebase
    task.id = taskDocs.id;
    return taskDocs.set(task);
  }

  static Future<QuerySnapshot<Task>> getAllTaskes(DateTime selectedDate) async {
    return await getTaskesCollection()
        .where('dataTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
  }

  static Stream<QuerySnapshot<Task>> listenForTaskRealDataUpdates(
      DateTime selectedDate) {
    // use to listen For Task Real Data Updates such as delete or add
    return getTaskesCollection()
        .where('dataTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(Task task) async {
    var snapshot = await getTaskesCollection().doc(task.id);
    return snapshot.delete();
  }
}
/*
// this code use to get data from firestore once without any updates for delete or ...
so we receive this code by listenForTaskRealDataUpdates because this listen for any updates

 static Future<List<Task>> getAllTaskes()async{
   var query =await getTaskesCollection().get();
   List<Task> tasks =query.docs.map((e) => e.data()).toList();
   return tasks ;
    // type of docs : List<QueryDocumentSnapshot<Task>>
    // this type must to convert into => List<Task>
    // map use to convert QueryDocumentSnapshot<Task> to => List<Task>
    //   List<Task> tasks = querySnapshot.docs.map((element) => element.data()).toList();
  }
 */
