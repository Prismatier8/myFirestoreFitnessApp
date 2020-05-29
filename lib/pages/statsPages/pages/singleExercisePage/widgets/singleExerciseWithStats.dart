import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exerciseImage.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/statsPages/provider/singleStatCalculationModel.dart';
import 'package:provider/provider.dart';

class SingleExerciseWithStats extends StatelessWidget {
  final ExerciseModel exercise;
  final List<StatType> statTypeList;

  SingleExerciseWithStats({@required this.exercise, @required this.statTypeList});
  @override
  Widget build(BuildContext context) {
    final cardWith = MediaQuery.of(context).size.width * 0.9;
    final statCalculationModel = Provider.of<SingleStatCalculationModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: cardWith,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ExerciseImage(exercise: exercise),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TitleDisplay(
                    title: exercise.title,
                    containerWidth: cardWith - 120,
                    containerHeight: 20,
                  ),
                ),
                Spacer(),
                statCalculationModel.getExerciseTrend(statTypeList, true)//TODO: Stat icon depending on result
              ],
            ),
          ),
        ),
      ),
    );
  }
}
