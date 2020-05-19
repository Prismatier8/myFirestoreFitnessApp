import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/staticExerciseImage.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:provider/provider.dart';

class SingleExerciseWithStats extends StatelessWidget {
  final ExerciseModel exercise;
  final List<StatType> statTypeList;

  SingleExerciseWithStats({@required this.exercise, @required this.statTypeList});
  @override
  Widget build(BuildContext context) {
    final statCalculationModel = Provider.of<SingleStatCalculationModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StaticExerciseImage(exercise),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(exercise.title,
                    style: TextStyle(
                        fontSize: 20
                    ),
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
