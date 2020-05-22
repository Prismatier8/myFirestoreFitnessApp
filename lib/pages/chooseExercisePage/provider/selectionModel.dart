import 'package:flutter/cupertino.dart';

class SelectionModel extends ChangeNotifier{
  String _currentDropDownSelection = "Alle Übungen";

  get currentDropDownSelection => _currentDropDownSelection;

  select(String selection){
    _currentDropDownSelection = selection;
    notifyListeners();
  }
}