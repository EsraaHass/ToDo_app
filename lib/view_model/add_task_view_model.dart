import 'package:todo/model/task.dart';
import 'package:todo/repository/repository.dart';
import 'package:todo/view/base/base.dart';
import 'package:todo/view/shared/only_date.dart';
import 'package:todo/view/shared/shared_data.dart';

abstract class AddTaskNavigator extends BaseNavigator {
  goback();
}

class AddTaskViewModel extends BaseViewModel<AddTaskNavigator> {
  Repository? repository;

  AddTaskViewModel({this.repository});

  void addTask(String title, String desc) {
    DateTime selectedDate = DateTime.now();
    Task task = Task(
        userId: SharedData.myUser!.id!,
        id: "",
        title: title,
        description: desc,
        dataTime: dateOnly(selectedDate),
        isDone: false);
    navigator?.showLoading();

    repository?.addTask(task).then((value) {
      navigator?.hideLoading();
      navigator?.goback();
      return navigator?.showMessage("Task Added Successfully",
          positiveActionName: "Yes", positiveAction: () {
        navigator?.goback();
      }, isCancelable: false);
    }).onError((error, stackTrace) {
      return navigator?.showMessage("SomeThing went wrong, try again late",
          positiveActionName: "Yes", positiveAction: () {
        navigator?.goback();
      }, isCancelable: false);
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return navigator?.showMessage("Task Added Locally",
          positiveActionName: "Yes", positiveAction: () {
        navigator?.goback();
      }, isCancelable: false);
    });
  }
}
