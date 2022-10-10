import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task.dart';
import 'package:todo/repository/repository.dart';
import 'package:todo/view/shared/only_date.dart';
import 'package:todo/view/shared/shared_data.dart';

class AddTaskRepository implements Repository {
  @override
  CollectionReference<Task> getTaskesCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: (snapshot, options) {
      return Task.fromFireStore(snapshot.data()!,snapshot.id);
    }, toFirestore: (task, options) {
      return task.toFireStore();
    });
  }

  @override
  Future<void> addTask(Task task) {
    var taskesCollection = getTaskesCollection();
    var taskDocs =
        taskesCollection.doc(); // create new document with auto id in firebase
    //////////////////////////////////////
    task.id = taskDocs.id;
    return taskDocs.set(task);
  }

  @override
  Future<void> deleteTask(Task task) async {
    var snapshot = await getTaskesCollection().doc(task.id);
    return snapshot.delete();
  }

  @override
  Future<void> editTaskDetails(Task task) async {
    CollectionReference todoRef = getTaskesCollection();
    return await todoRef.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': dateOnly(task.dataTime!).millisecondsSinceEpoch,
    });
  }

  @override
  CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) {
              return MyUser.fromFireStore(snapshot.data()!);
            },
            toFirestore: (MyUser, SetOptions) => MyUser.toFireStore());
  }

  @override
  Future<MyUser?> insertUser(MyUser myUser) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(myUser.id);
    await documentRef.set(myUser);
    return myUser;
  }

  @override
  Stream<QuerySnapshot<Task>> listenForTaskRealDataUpdates(
      DateTime selectedDate) {
    printData(selectedDate);
    try {
      return getTaskesCollection()
          .where('dataTime',isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
          .where('userId', isEqualTo: SharedData.myUser!.id)
          .snapshots();
    } on Exception catch (e) {
      print("GMgm: $e");
      rethrow;
    }
  }

  Future<void> printData(DateTime selectedDate) async {
    final data = await getTaskesCollection()
        .where('dataTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .where('id', isEqualTo: SharedData.myUser!.id)
        .get();
    final List<Task> tasks = data.docs.map((e) => e.data()).toList();
    print(tasks);
  }

  @override
  Future<MyUser?> retriveUserById(String id) async {
    var collection = getUserCollection();
    var documentRef = collection.doc(id);
    var result = await documentRef.get();
    return result.data();
  }

  @override
  Future<void> udateDeleteTask(Task task) {
    CollectionReference isDoneupdate = getTaskesCollection();
    return isDoneupdate.doc(task.id).update({
      'isDone': task.isDone! ? false : true,
    });
  }

  @override
  Future<void> updateTaskDeteails(Task task) {
    CollectionReference todoUpdate = getTaskesCollection();
    return todoUpdate.doc(task.id).set(task);
  }
}
