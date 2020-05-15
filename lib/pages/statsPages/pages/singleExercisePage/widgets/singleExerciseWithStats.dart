import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:provider/provider.dart';

class SingleExerciseWithStats extends StatelessWidget {
  final String exerciseTitle;
  final List<StatType> statTypeList;

  SingleExerciseWithStats({@required this.exerciseTitle, @required this.statTypeList});
  @override
  Widget build(BuildContext context) {
    final statCalculationModel = Provider.of<SingleStatCalculationModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: Card(
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(exerciseTitle,
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
