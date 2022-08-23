import 'package:flutter/material.dart';
import 'package:todo/Home/list/add_task_bottom-sheet.dart';
import 'package:todo/Home/list/list_tab.dart';
import 'package:todo/Home/settings/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white, width: 3),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  var tabs = [List_tab(), Settings_tab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddTaskBottomSheet();
        },
        isScrollControlled: true);
  }
}
