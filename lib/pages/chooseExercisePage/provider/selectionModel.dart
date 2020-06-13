import 'package:flutter/cupertino.dart';

class SelectionModel extends ChangeNotifier{
  String _currentDropDownSelection = "Alle Übungen";

  get currentDropDownSelection => _currentDropDownSelection;

  ///Change State to new selection -> The UI will be notified if called
  select(String selection){
    _currentDropDownSelection = selection;
    notifyListeners();
  }
}