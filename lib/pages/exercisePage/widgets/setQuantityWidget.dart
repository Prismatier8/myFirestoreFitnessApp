import 'package:flutter/material.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/exercisePage/provider/setQuantityModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class SetQuantityWidget extends StatefulWidget {
  @override
  _SetQuantityWidgetState createState() => _SetQuantityWidgetState();
}

class _SetQuantityWidgetState extends State<SetQuantityWidget> {

  @override
  Widget build(BuildContext context) {
    final setQuantityModel = Provider.of<SetQuantityModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Center(
            child: Text(Names.BASIC_SETS,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              setQuantityModel.setQuantity.toString(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(width: 10,),
            ///Increment
            ButtonTheme(
              minWidth: 0,
              shape: CircleBorder(),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    setQuantityModel.increaseSetQuantity();
                  });
                },
                color: Theme.of(context).accentColor,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
            //SizedBox(width: 10,),
            ///decrement
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: ButtonTheme(
                shape: CircleBorder(),
                minWidth: 0,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      setQuantityModel.decreaseSetQuantity();
                    });
                  },
                  color: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
