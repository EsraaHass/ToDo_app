import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/Home/list/Task_body.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/task.dart';

class List_tab extends StatefulWidget {
  @override
  State<List_tab> createState() => _List_tabState();
}

class _List_tabState extends State<List_tab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
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
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDataBase.listenForTaskRealDataUpdates(selectedDate),
            builder: (buildContext, snapshot) {
              if (snapshot.hasError) {
                // execute if has errors
                return Text('Error Loading Data, Please try again later');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // execute if data is loading
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // execute if snapshot has data
              var data =
                  snapshot.data?.docs.map((element) => element.data()).toList();
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
    );
  }
}
