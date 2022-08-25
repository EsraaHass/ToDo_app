import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/Presentation_layer/dialogDetails.dart';
import 'package:todo/Presentation_layer/list/build_text_form_field.dart';
import 'package:todo/Presentation_layer/my_theme.dart';
import 'package:todo/Presentation_layer/only_date.dart';
import 'package:todo/database_layer/my_database.dart';
import 'package:todo/database_layer/task.dart';
import 'package:todo/stateManageMent_layer/provider.dart';

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
    var provider = Provider.of<AppProvider>(context);
    return Container(
      color: provider.isDark() ? Colors.black : Colors.white,
      height: MediaQuery.of(context).size.height * .6,
      padding: const EdgeInsets.all(12),
      child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.addTask,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: provider.isDark()
                                        ? Colors.white
                                        : MyTheme.lightPrimary,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuildTextFormField(
                            titlecontroller,
                            AppLocalizations.of(context)!.validateTitle,
                            AppLocalizations.of(context)!.title),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildTextFormField(
                            desccontroller,
                            AppLocalizations.of(context)!.validateDesc,
                            AppLocalizations.of(context)!.description),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.date,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 18,
                                    color: provider.isDark()
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            selectedDatePicker();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Center(
                              child: Text(
                                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: provider.isDark()
                                          ? Colors.white
                                          : MyTheme.lightPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addNewTask();
                },
                child: Text(AppLocalizations.of(context)!.submit),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        provider.isDark() ? MyTheme.red : MyTheme.lightPrimary),
              ),
            ],
          )),
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
      showLoadingDialog(context, AppLocalizations.of(context)!.load);
      MyDataBase.addTask(task).then((value) {
        // called when future is complete
        // show message
        hideLoadingDialog(context);
        return showMassege(context, AppLocalizations.of(context)!.successAdd,
            positiveActionName: AppLocalizations.of(context)!.yes,
            positiveAction: () {
          Navigator.pop(context);
        }, isCancelable: false);
      }).onError((error, stackTrace) {
        // called when future is complete
        // show message
        return showMassege(context, AppLocalizations.of(context)!.errorAdd,
            positiveActionName: AppLocalizations.of(context)!.yes,
            positiveAction: () {
          Navigator.pop(context);
        }, isCancelable: false);
      }).timeout(const Duration(seconds: 5), onTimeout: () {
        // called when future is complete
        // show message
        return showMassege(context, AppLocalizations.of(context)!.timeOut,
            positiveActionName: AppLocalizations.of(context)!.yes,
            positiveAction: () {
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
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }
}
