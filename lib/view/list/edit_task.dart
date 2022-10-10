import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/domain_layer/provider.dart';
import 'package:todo/model/task.dart';
import 'package:todo/repository/repository_impl.dart';
import 'package:todo/view/shared/my_theme.dart';

class EditTask extends StatefulWidget {
  Task task;

  EditTask(this.task);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late AppProvider provider;
  AddTaskRepository addTaskRepository = AddTaskRepository();
  var titlecontroller = TextEditingController();
  var desccontroller = TextEditingController();
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    selectedDate = widget.task.dataTime!;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .25,
              decoration: BoxDecoration(
                  color:
                      provider.isDark() ? MyTheme.red : MyTheme.lightPrimary),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.todolist,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 120,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .75,
                decoration: BoxDecoration(
                    color: provider.isDark() ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: const Radius.circular(25),
                        topLeft: Radius.circular(25))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.editTask,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: provider.isDark()
                                      ? Colors.white
                                      : Colors.black,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      // controller: titlecontroller,
                      initialValue: widget.task.title,
                      onChanged: (String? value) {
                        widget.task.title = value ?? "";
                      },
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: provider.isDark()
                              ? Colors.white70
                              : Colors.grey.shade800,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      initialValue: widget.task.description,
                      onChanged: (String? value) {
                        widget.task.description = value ?? "";
                      },
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: provider.isDark()
                              ? Colors.white70
                              : Colors.grey.shade800,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color:
                              provider.isDark() ? Colors.white : Colors.black,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.date,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color:
                                provider.isDark() ? Colors.white : Colors.black,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: InkWell(
                      onTap: () {
                        selectedDatePicker();
                      },
                      child: Text(
                        '${selectedDate.year} / ${selectedDate.month} / ${selectedDate.day}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: provider.isDark()
                                    ? Colors.white70
                                    : Colors.black,
                                fontSize: 18),
                      ),
                    )),
                    const Spacer(),
                    Center(
                      child: MaterialButton(
                        minWidth: 250,
                        height: 50,
                        color: provider.isDark()
                            ? MyTheme.red
                            : MyTheme.lightPrimary,
                        onPressed: () {
                          editTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.saveChanges,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: provider.isDark()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectedDatePicker() async {
    var chooseDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }
  }

  void editTask() async {
    Navigator.pop(context);
    await addTaskRepository.editTaskDetails(widget.task);
  }
}
