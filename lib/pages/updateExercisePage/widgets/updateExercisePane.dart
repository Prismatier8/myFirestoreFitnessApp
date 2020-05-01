import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/setQuantityDialog.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/sets.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class UpdateExercisePane extends StatefulWidget {

  final ExerciseModel exerciseModel;
  UpdateExercisePane({@required this.exerciseModel});
  @override
  _UpdateExercisePaneState createState() => _UpdateExercisePaneState();
}

class _UpdateExercisePaneState extends State<UpdateExercisePane> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: () {
              //TODO: Define Tap when user is trying to add muscleGroups to exercise
            },
            child: Text(
              Names.BASIC_MUSCLEGROUPS,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text("The future musclegroups"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: () {
              //_showSetQuantityDialog(context);
            },
            child: Text(
              Names.BASIC_SETS,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Center(
          child: Sets(
            exerciseModel: widget.exerciseModel,
          ),
        ),
      ],
    );
  }
/*
  _showSetQuantityDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SetQuantityDialog();
        }).then((value){
          setState(() {
            _selectedSetQuantity = value;
          });

    });
  }

 */
}