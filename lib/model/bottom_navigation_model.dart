import 'package:flutter/material.dart';
import 'package:todo_app/ui/record_screen.dart';
import 'package:todo_app/ui/manage_db_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    const RecordScreen(),
    const ManageDBScreen(),
  ];

  int selectedIndex = 0;

  void change(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() {
    return options[selectedIndex];
  }
}
