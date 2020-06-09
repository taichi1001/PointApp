import 'package:flutter/material.dart';
import 'package:todo_app/ui/all_records_screen.dart';
import 'package:todo_app/ui/completed_records_screen.dart';
import 'package:todo_app/ui/incompleted_records_screen.dart';

class BottomNavigationModel with ChangeNotifier {
  final List<Widget> options = [
    const AllRecordsScreen(),
    const IncompletedTodosScreen(),
    const CompletedTodosScreen(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void change(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() {
    return options[selectedIndex];
  }
}
