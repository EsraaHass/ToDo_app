import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/model/task.dart';
import 'package:todo/repository/repository_impl.dart';
import 'package:todo/view/list/edit_task.dart';
import 'package:todo/view/shared/dialogDetails.dart';
import 'package:todo/view/shared/my_theme.dart';

class Task_Body extends StatelessWidget {
  Task task;
  AddTaskRepository addTaskRepository = AddTaskRepository();

  Task_Body(this.task);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditTask(task),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  addTaskRepository.deleteTask(task).then((value) {
                    showMassege(
                        context, AppLocalizations.of(context)!.successDelete,
                        positiveActionName: AppLocalizations.of(context)!.yes,
                        isCancelable: false);
                  }).onError((error, stackTrace) {
                    showMassege(
                        context, AppLocalizations.of(context)!.errorLoad,
                        positiveActionName: AppLocalizations.of(context)!.yes,
                        isCancelable: false);
                  }).timeout(const Duration(seconds: 5), onTimeout: () {
                    showMassege(
                        context, AppLocalizations.of(context)!.deleteLocally,
                        isCancelable: false);
                  });
                },
                backgroundColor: MyTheme.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: provider.isDark() ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 80,
                  decoration: BoxDecoration(
                      color:
                          task.isDone! ? MyTheme.green : MyTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: task.isDone!
                                    ? MyTheme.green
                                    : Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        task.description ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: task.isDone!
                                ? MyTheme.green
                                : Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    addTaskRepository.udateDeleteTask(task);
                  },
                  child: task.isDone!
                      ? Text(
                          'Done !',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.green),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: task.isDone!
                                  ? MyTheme.green
                                  : MyTheme.lightPrimary,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
