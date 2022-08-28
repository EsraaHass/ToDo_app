import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/Presentation_layer/list/Task_body.dart';
import 'package:todo/Presentation_layer/my_theme.dart';
import 'package:todo/database_layer/my_database.dart';
import 'package:todo/database_layer/task.dart';
import 'package:todo/stateManageMent_layer/provider.dart';

class List_tab extends StatefulWidget {
  @override
  State<List_tab> createState() => _List_tabState();
}

class _List_tabState extends State<List_tab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.10,
            decoration: BoxDecoration(color: MyTheme.lightPrimary),
            child: Text(
              AppLocalizations.of(context)!.todoApp,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CalendarTimeline(
                  locale: 'en',
                  showYears: true,
                  initialDate: selectedDate,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  onDateSelected: (date) {
                    // on user choose new date
                    if (date == null) return;
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  leftMargin: 20,
                  monthColor:
                      provider.isDark() ? Colors.white : MyTheme.lightPrimary,
                  dayColor:
                      provider.isDark() ? Colors.white : MyTheme.lightPrimary,
                  activeDayColor:
                      provider.isDark() ? Colors.white : MyTheme.lightPrimary,
                  activeBackgroundDayColor:
                      provider.isDark() ? Colors.black : Colors.white,
                  dotsColor:
                      provider.isDark() ? Colors.white : MyTheme.lightPrimary,
                  selectableDayPredicate: (date) => true,
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Task>>(
                  stream: MyDataBase.listenForTaskRealDataUpdates(selectedDate),
                  builder: (buildContext, snapshot) {
                    if (snapshot.hasError) {
                      // execute if has errors
                      return Text(AppLocalizations.of(context)!.errorLoad);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      // execute if data is loading
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // execute if snapshot has data
                    var data = snapshot.data?.docs
                        .map((element) => element.data())
                        .toList();
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Task_Body(data[index]);
                      },
                      itemCount: data!.length,
                    );
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

