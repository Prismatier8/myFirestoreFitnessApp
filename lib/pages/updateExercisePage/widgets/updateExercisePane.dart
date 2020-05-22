import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/muscleGroupDialog.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/muscleGroupDisplay.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/updateExerciseImage.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/sets.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class UpdateExercisePane extends StatefulWidget {

  final ExerciseModel exercise;
  UpdateExercisePane({@required this.exercise});
  @override
  _UpdateExercisePaneState createState() => _UpdateExercisePaneState();
}

class _UpdateExercisePaneState extends State<UpdateExercisePane> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topRight,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 10),
              child: UpdateExerciseImage(widget.exercise),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: () {
              _showMuscleGroupDialog(context);
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.fitness_center, color: Theme.of(context).accentColor),
                SizedBox(width: 20,),
                Text(
                  Names.BASIC_MUSCLEGROUPS,
                  style: TextStyle(fontSize: 20),
                ),
              ],

            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: MuscleGroupDisplay(widget.exercise),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: () {
              //_showSetQuantityDialog(context);
            },

            child: Row(
              children: <Widget>[
                Icon(Icons.build, color: Theme.of(context).accentColor,),
                SizedBox(
                  width: 20,
                ),
                Text(
                  Names.BASIC_SETS,
                  style: TextStyle(fontSize: 20),
                ),
              ],

            ),
          ),
        ),
        Center(
          child: Sets(
            exerciseModel: widget.exercise,
          ),
        ),
      ],
    );
  }
  void _showMuscleGroupDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MuscleGroupDialog(widget.exercise);
        }).then((value) {
          setState(() {

          });
    });
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