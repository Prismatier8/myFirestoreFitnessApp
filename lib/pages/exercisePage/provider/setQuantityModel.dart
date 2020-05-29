import 'package:flutter/cupertino.dart';

class SetQuantityModel extends ChangeNotifier{
  final _maximumSetQuantity = 6;
  final _minimumSetQuantity = 1;

  int setQuantity = 1;

  increaseSetQuantity(){
    if(setQuantity >= _minimumSetQuantity
        && setQuantity < _maximumSetQuantity){
      setQuantity++;
    }
  }
  decreaseSetQuantity(){
    if(setQuantity >= (_minimumSetQuantity + 1)
        && setQuantity <= _maximumSetQuantity){
      setQuantity--;
    }
  }
  clear(){
    setQuantity = 1;
  }

}