import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';

class UpdateExerciseNavigator extends StatelessWidget {
  final ExerciseModel exerciseModel;
  UpdateExerciseNavigator(this.exerciseModel);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, NamedRoutes.ROUTE_ADDEXERCISEPAGE, arguments: exerciseModel);
        },
        child: Icon(Icons.settings,
          color: Theme.of(context).accentColor,
          size: 35,
        ),
      ),
    );
  }
}
