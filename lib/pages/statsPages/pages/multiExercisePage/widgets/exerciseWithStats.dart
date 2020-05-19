import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/globalWidgets/staticExerciseImage.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class ExerciseWithStats extends StatelessWidget {
  final exercisesSnapshot;
  final builderIndex;
  ExerciseWithStats(
      {@required this.exercisesSnapshot, @required this.builderIndex});

  @override
  Widget build(BuildContext context) {
    final executionService =
    Provider.of<ExecutionService>(context, listen: false);
    final statCalculationModel =
    Provider.of<SingleStatCalculationModel>(context, listen: false);

    return Align(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
              context, NamedRoutes.ROUTE_STAT_SINGLEEXERCISEPAGE,
              arguments: exercisesSnapshot.data[builderIndex]);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StaticExerciseImage(exercisesSnapshot.data[builderIndex]),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      exercisesSnapshot.data[builderIndex].title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Spacer(),
                  FutureBuilder(
                    future: executionService.getExecutions(
                        exercisesSnapshot.data[builderIndex], 2, true),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ExecutionData>> executionSnapshot) {
                      if (executionSnapshot.hasData) {
                        List<StatType> statTypeList = statCalculationModel
                            .compareExecution(executionSnapshot.data);
                        return statCalculationModel.getExerciseTrend(statTypeList, true);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
