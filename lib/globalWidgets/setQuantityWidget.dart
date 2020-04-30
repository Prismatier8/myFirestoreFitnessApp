import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/setQuantityModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class SetQuantityWidget extends StatefulWidget {
  @override
  _SetQuantityWidgetState createState() => _SetQuantityWidgetState();
}

class _SetQuantityWidgetState extends State<SetQuantityWidget> {
  final _defaultTextSize = 30.0;
  final _defaultButtonRoundness = 30.0;


  @override
  Widget build(BuildContext context) {
    final setQuantityModel = Provider.of<SetQuantityModel>(context);

    return Column(
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
              setQuantityModel.setQuantity.toString(),
              style: TextStyle(
                fontSize: _defaultTextSize,
              ),
            ),
            SizedBox(width: 10,),
            ///Increment
            RaisedButton(
              onPressed: () {
                setState(() {
                  setQuantityModel.increaseSetQuantity();
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
                  setQuantityModel.decreaseSetQuantity();
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
    );
  }
}
