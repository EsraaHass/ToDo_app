import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task.dart';

abstract class Repository {
  CollectionReference<Task> getTaskesCollection();

  Future<void> addTask(Task task);

  Stream<QuerySnapshot<Task>> listenForTaskRealDataUpdates(
      DateTime selectedDate);

  Future<void> deleteTask(Task task);

  Future<void> udateDeleteTask(Task task);

  Future<void> updateTaskDeteails(Task task);

  Future<void> editTaskDetails(Task task);

  CollectionReference<MyUser> getUserCollection();

  Future<MyUser?> retriveUserById(String id);

  Future<MyUser?> insertUser(MyUser myUser);
}
