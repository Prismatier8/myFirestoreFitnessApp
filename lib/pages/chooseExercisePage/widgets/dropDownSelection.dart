import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/provider/selectionModel.dart';
import 'package:provider/provider.dart';

class DropDownSelection extends StatefulWidget {
  @override
  _DropDownSelectionState createState() => _DropDownSelectionState();
}

class _DropDownSelectionState extends State<DropDownSelection> {
  @override
  Widget build(BuildContext context) {

    return Consumer<SelectionModel>(
      builder: (context, selectionModel, _){
        return DropdownButton(
          iconEnabledColor: Colors.white,
          dropdownColor: Theme.of(context).accentColor,
          value: selectionModel.currentDropDownSelection,
          onChanged: (value) {
            setState(() {
              selectionModel.select(value);
            });
          },
          items: <String>[
            "Alle Übungen",
            "Bauch",
            "Bizeps",
            "Brust",
            "Gesäß",
            "Hintere Oberschenkel",
            "Rücken",
            "Schultern",
            "Trapez",
            "Trizeps",
            "Unterarm",
            "Vordere Oberschenkel",
            "Waden",
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),),
            );
          }).toList(),
        );
      },
    );
  }
}
