import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/repository/repository_impl.dart';
import 'package:todo/view/list/build_text_form_field.dart';
import 'package:todo/view/shared/my_theme.dart';
import 'package:todo/view_model/add_task_view_model.dart';

import '../base/base.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState
    extends BaseState<AddTaskBottomSheet, AddTaskViewModel>
    implements AddTaskNavigator {
  var formKey = GlobalKey<FormState>();
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();

  @override
  AddTaskViewModel initViewModel() {
    return AddTaskViewModel(repository: AddTaskRepository());
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        color: provider.isDark() ? Colors.black : Colors.white,
        height: MediaQuery.of(context).size.height * .6,
        padding: const EdgeInsets.all(12),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.addTask,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: provider.isDark()
                            ? Colors.white
                            : MyTheme.lightPrimary,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
                      primary: provider.isDark()
                          ? MyTheme.red
                          : MyTheme.lightPrimary),
                ),
              ],
            )),
      ),
    );
  }

  void addNewTask() {
    if (formKey.currentState?.validate() == true) {
      viewModel.addTask(titlecontroller.text, desccontroller.text);
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

  @override
  goback() {
    Navigator.pop(context);
  }
}
