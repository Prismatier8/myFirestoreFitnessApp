import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exerciseImage.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/statsPages/provider/singleStatCalculationModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class PlanWithSingleExercise{
  PlanModel plan;
  ExerciseModel exercise;
  PlanWithSingleExercise(this.plan, this.exercise);
}
class ExerciseWithStats extends StatelessWidget {
  final PlanModel plan;
  final exercisesSnapshot;
  final builderIndex;
  ExerciseWithStats(
      {@required this.exercisesSnapshot,
        @required this.builderIndex,
      @required this.plan});

  @override
  Widget build(BuildContext context) {
    final cardWith = MediaQuery.of(context).size.width * 0.9;
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
              arguments: PlanWithSingleExercise(plan, exercisesSnapshot.data[builderIndex]));
        },
        child: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Container(
            width: cardWith,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ExerciseImage(exercise: exercisesSnapshot.data[builderIndex]),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TitleDisplay(
                      title: exercisesSnapshot.data[builderIndex].title,
                      containerWidth: cardWith - 120,
                      containerHeight: 20,
                    ),
                  ),
                  Spacer(),
                  FutureBuilder(
                    future: executionService.getExecutionsOnPlan(plan
                        ,exercisesSnapshot.data[builderIndex], 2, true),
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
