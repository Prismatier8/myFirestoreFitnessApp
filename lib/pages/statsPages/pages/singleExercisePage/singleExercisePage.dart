import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/multiExercisePage/widgets/exerciseWithStats.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/widgets/statBuilder.dart';


class SingleExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlanWithSingleExercise planWithSingleExercise = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(planWithSingleExercise.exercise.title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          )
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,

      ),
      body: SingleChildScrollView(
        child: StatBuilder(
          plan: planWithSingleExercise.plan,
          buildLength: 2,
          exercise: planWithSingleExercise.exercise,
        ),
      ),
    );
  }
}
