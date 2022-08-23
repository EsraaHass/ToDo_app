import 'package:flutter/material.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/dialogDetails.dart';
import 'package:todo/only_date.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add New Task',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: titlecontroller,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Title !';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
                TextFormField(
                  controller: desccontroller,
                  maxLines: 4,
                  minLines: 4,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please Enter Description!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Select Date',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 22),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    selectedDatePicker();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                addNewTask();
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void addNewTask() {
    if (formKey.currentState?.validate() == true) {
      String title = titlecontroller.text;
      String desc = desccontroller.text;
      Task task = Task(
          title: title,
          description: desc,
          dataTime: dateOnly(selectedDate),
          isDone: false);
      showLoadingDialog(context, 'Loading...');
      MyDataBase.addTask(task).then((value) {
        // called when future is complete
        // show message
        hideLoadingDialog(context);
        return showMassege(context, 'Task Added Successfully',
            positiveActionName: 'YES', positiveAction: () {
          Navigator.pop(context);
        }, isCancelable: false);
      }).onError((error, stackTrace) {
        // called when future is complete
        // show message
        return showMassege(context, 'SomeThing went wrong, try again late',
            positiveActionName: 'Yes', positiveAction: () {
          Navigator.pop(context);
        }, isCancelable: false);
      }).timeout(Duration(seconds: 5), onTimeout: () {
        // called when future is complete
        // show message
        return showMassege(context, 'Task Added Locally',
            positiveActionName: 'Go', positiveAction: () {
          Navigator.pop(context);
        }, isCancelable: false);
      });
    }
  }

  DateTime selectedDate = DateTime.now();

  void selectedDatePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }
}
