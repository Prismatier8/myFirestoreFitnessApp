import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/muscleGroupModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:provider/provider.dart';

class MuscleRow extends StatefulWidget {
  final MuscleGroupModel muscleGroupModel;
  final ExerciseModel exercise;
  MuscleRow({@required this.muscleGroupModel, @required this.exercise});
  @override
  _MuscleRowState createState() => _MuscleRowState();
}

class _MuscleRowState extends State<MuscleRow> {
  bool _currentCheckBoxValue;
  @override
  void initState() {
    super.initState();
    _currentCheckBoxValue = _checkForExistingValue();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          _currentCheckBoxValue = !_currentCheckBoxValue;
          _updateExercise(_currentCheckBoxValue);
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
          value: _currentCheckBoxValue,
            onChanged: (value){
              setState(() {
                _currentCheckBoxValue = value;
                _updateExercise(_currentCheckBoxValue);
              });
            },
          ),
          Text(widget.muscleGroupModel.title)
        ],
      ),
    );
  }
  ///Checks if exercise has muscleGroup stored
  bool _checkForExistingValue(){
    for(int i = 0; i<widget.exercise.muscleGroupReferences.length; i++){
      if(widget.exercise.muscleGroupReferences[i]
          == widget.muscleGroupModel.title){
        return true;
      }
    }
    return false;
}
///Adds or remove muscleGroup from exercise. Depends on Checkbox value
  _updateExercise(bool value){
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    List<String> muscleGroup = [widget.muscleGroupModel.title];
    if(value == true){
      Map<String, dynamic> map = {"muscleGroupReferences" : FieldValue.arrayUnion(muscleGroup)};
      exerciseService.updateExercise(widget.exercise.title, map);
    } else {
      Map<String, dynamic> map = {"muscleGroupReferences" : FieldValue.arrayRemove(muscleGroup)};
      exerciseService.updateExercise(widget.exercise.title, map);
    }

  }
}
