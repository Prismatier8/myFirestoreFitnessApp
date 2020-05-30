import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).accentColor,
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        Names.BASIC_CANCELBUTTON,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
