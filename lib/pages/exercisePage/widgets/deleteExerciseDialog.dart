import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/cancelButton.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/imageService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class DeleteExerciseDialog extends StatelessWidget {
  final ExerciseModel exercise;
  DeleteExerciseDialog(this.exercise);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(exercise.title + " löschen?"),
        actions: <Widget>[
          CancelButton(),
          ///DeleteButton
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).accentColor,
            onPressed: () {
              _deleteExerciseData(context, exercise);
              Navigator.pop(context);
            },
            child: Text(
              Names.BASIC_DELETE,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]
    );
  }
  _deleteExerciseData(BuildContext context, ExerciseModel exercise){
    _deleteExercise(context, exercise);
    _deleteSets(context, exercise);
    _deleteExecutions(context, exercise);
    _deleteReferenceOnPlan(context, exercise);
    _deleteImage(context, exercise);
  }
  ///Delete all sets referenced to exercise
  _deleteSets(BuildContext context, ExerciseModel exercise){
    final setService = Provider.of<SetService>(context, listen: false);
    setService.deleteSets(exercise.title);
  }
  ///delete exercise
  _deleteExercise(BuildContext context, ExerciseModel exercise){
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    exerciseService.deleteExercise(exercise.title);
  }
  ///Delete all executions that contain reference to exercise
  _deleteExecutions(BuildContext context, ExerciseModel exercise){
    final executionService = Provider.of<ExecutionService>(context, listen: false);
    executionService.deleteExecutionByExercise(exercise.title);
  }
  ///Delete reference of exercise in all plans
  _deleteReferenceOnPlan(BuildContext context, ExerciseModel exercise){
    final planService = Provider.of<PlanService>(context, listen: false);
    planService.deleteExerciseFromPlans(exercise.title);
  }
  ///Delete the image inside Firebase storage
  _deleteImage(BuildContext context, ExerciseModel exercise){
    if(exercise.imageRef.isNotEmpty){
      final imageService = Provider.of<ImageService>(context, listen: false);
      imageService.deleteImage(exercise.imageRef);
    }
  }
}
