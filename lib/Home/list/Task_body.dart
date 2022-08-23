import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';
import 'package:todo/dialogDetails.dart';
import 'package:todo/my_theme.dart';

class Task_Body extends StatelessWidget {
  Task task;

  Task_Body(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) {
                MyDataBase.deleteTask(task).then((value) {
                  showMassege(context, 'Task Deleted Successfully',
                      positiveActionName: 'OK', isCancelable: false);
                }).onError((error, stackTrace) {
                  showMassege(context, 'SomeThing went wrong, try again later',
                      positiveActionName: 'Yes', isCancelable: false);
                }).timeout(Duration(seconds: 5), onTimeout: () {
                  showMassege(context, 'Task Deleted Locally',
                      isCancelable: false);
                });
              },
              backgroundColor: MyTheme.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 80,
                decoration: BoxDecoration(
                    color: MyTheme.lightPrimary,
                    borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      task.description ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Icon(Icons.access_time),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //       '8:30 am',
                    //       style: Theme.of(context).textTheme.bodySmall,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: MyTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
