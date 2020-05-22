import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:provider/provider.dart';

class MuscleGroupDisplay extends StatelessWidget {
  final ExerciseModel exercise;
  MuscleGroupDisplay(this.exercise);
  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    return FutureBuilder(
      future: exerciseService.getExerciseData(exercise.title),
      builder: (BuildContext context, AsyncSnapshot<ExerciseModel> snapshot){
        if(snapshot.hasData){
          return _transformText(snapshot.data);
        } else if(snapshot.hasError){
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
  Widget _transformText(ExerciseModel exercise){
    String finalText = "";
    for(int i = 0; i<exercise.muscleGroupReferences.length; i++){
      if(i == exercise.muscleGroupReferences.length - 1) {
        finalText = finalText + "${exercise.muscleGroupReferences[i]}";
      } else {
        finalText = finalText + "${exercise.muscleGroupReferences[i]}, ";
      }

    }
    return Text(finalText);
  }
}
