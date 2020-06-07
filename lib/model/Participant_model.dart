import 'package:flutter/material.dart';

class ParticipantModel with ChangeNotifier {
  List<String> _rangePeople = ['1', '2', '3','4'];
  String _rangeValue = '1';
  List<String> get rangePeople => _rangePeople;
  String get rangeValue => _rangeValue;

  void setRangeValue(String value){
    _rangeValue = value;
    notifyListeners();
  }
}