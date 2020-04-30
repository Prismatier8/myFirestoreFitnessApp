import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

enum EventType {decrement, increment}

class SetQuantityDialog extends StatefulWidget {
  @override
  _SetQuantityDialogState createState() => _SetQuantityDialogState();
}

class _SetQuantityDialogState extends State<SetQuantityDialog> {

  int _currentSetQuantity = 1;
  final _defaultTextSize = 30.0;
  final _defaultButtonRoundness = 30.0;
  final _maximumSetQuantity = 6;
  final _minimumSetQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      content: Container(
        width: 200,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(Names.BASIC_SETS,
              style: TextStyle(
                fontSize: _defaultTextSize,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentSetQuantity.toString(),
                  style: TextStyle(
                    fontSize: _defaultTextSize,
                  ),
                ),
                SizedBox(width: 10,),
                ///Increment
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _incrementSetQuantity();
                    });
                  },
                  color: Theme.of(context).accentColor,
                  child: Icon(Icons.add, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_defaultButtonRoundness),
                  ),
                ),

                SizedBox(width: 10,),
                ///decrement
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      _decrementSetQuantity();
                    });
                  },
                  color: Theme.of(context).accentColor,
                  child: Icon(Icons.remove, color: Colors.white,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_defaultButtonRoundness),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(Names.BASIC_ACCEPT,
          style: TextStyle(
            color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,

        ),
      ],
    );
  }
  _incrementSetQuantity(){
    if(_currentSetQuantity >= _minimumSetQuantity
        && _currentSetQuantity < _maximumSetQuantity){
      _currentSetQuantity++;
    }
  }
  _decrementSetQuantity(){
    if(_currentSetQuantity >= (_minimumSetQuantity + 1)
        && _currentSetQuantity <= _maximumSetQuantity){
      _currentSetQuantity--;
    }
  }
}
