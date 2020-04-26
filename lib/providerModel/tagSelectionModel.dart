
import 'package:flutter/cupertino.dart';

class TagSelectionModel extends ChangeNotifier{
  List<String> _tagNames = [];
  int _currentTagSelectionQuantity = 0;

  get tagNamesList => _tagNames;
  get currentSelectionQuantity => _currentTagSelectionQuantity;

  int length(){
    return _tagNames.length;
  }
  increaseQuantity(String tagName){
    _tagNames.add(tagName);
    _currentTagSelectionQuantity++;
    notifyListeners();
  }
  decreaseQuantity(String tagName){
    _tagNames.remove(tagName);
    _currentTagSelectionQuantity--;
    notifyListeners();
  }
  clear(){
    _tagNames = [];
    _currentTagSelectionQuantity = 0;
  }

}