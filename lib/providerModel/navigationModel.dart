
import 'package:flutter/material.dart';

class NavigationModel extends ChangeNotifier {

  int _index = 0;

  void changeIndex(int index){
    _index = index;
    notifyListeners();
  }
  int getIndex() => _index;
}