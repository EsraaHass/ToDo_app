import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/Presentation_layer/dialogDetails.dart';
import 'package:todo/Presentation_layer/my_theme.dart';
import 'package:todo/database_layer/my_database.dart';
import 'package:todo/database_layer/task.dart';
import 'package:todo/stateManageMent_layer/provider.dart';

class Task_Body extends StatelessWidget {
  Task task;

  Task_Body(this.task);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) {
                MyDataBase.deleteTask(task).then((value) {
                  showMassege(
                      context, AppLocalizations.of(context)!.successDelete,
                      positiveActionName: AppLocalizations.of(context)!.yes,
                      isCancelable: false);
                }).onError((error, stackTrace) {
                  showMassege(context, AppLocalizations.of(context)!.errorLoad,
                      positiveActionName: AppLocalizations.of(context)!.yes,
                      isCancelable: false);
                }).timeout(Duration(seconds: 5), onTimeout: () {
                  showMassege(
                      context, AppLocalizations.of(context)!.deleteLocally,
                      isCancelable: false);
                });
              },
              backgroundColor: MyTheme.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: provider.isDark() ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                width: 4,
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
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: MyTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
