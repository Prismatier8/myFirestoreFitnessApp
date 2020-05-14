import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exercisePicture.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/widgets/statBuilder.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:provider/provider.dart';


class SingleExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseModel exercise = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider(
      create: (context) => SingleStatCalculationModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            exercise.title,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: ExercisePicture(exercise),
            ),
            StatBuilder(
              buildLength: 2,
              exercise: exercise,
            ),
          ],
        ),
      ),
    );
  }
}
