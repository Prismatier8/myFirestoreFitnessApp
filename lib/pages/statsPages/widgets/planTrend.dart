import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:provider/provider.dart';

class PlanTrend extends StatelessWidget {
  final PlanModel plan;
  PlanTrend(this.plan);
  @override
  Widget build(BuildContext context) {
    final exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    final statCalculationModel =
        Provider.of<SingleStatCalculationModel>(context, listen: false);

    return FutureBuilder(
      future: exerciseService.getExerciseModelsFromPlan(plan),
      builder: (BuildContext context,
          AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot) {
        if (exerciseSnapshot.hasData) {
          return FutureBuilder(
            future: _planFactor(context, exerciseSnapshot.data, statCalculationModel),
            builder: (BuildContext context, AsyncSnapshot<int> factorSnapshot) {
              if (factorSnapshot.hasData) {
                return statCalculationModel.buildIcon(factorSnapshot.data);
              } else {
                return CircularProgressIndicator(
                );
              }
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
  ///Calculates
  Future<int> _planFactor(
      BuildContext context,
      List<ExerciseModel> exerciseList,
      SingleStatCalculationModel statCalculationModel) async {
    final executionService =
        Provider.of<ExecutionService>(context, listen: false);

    int factor = 0;
    ///Exercise iteration
    for (int i = 0; i < exerciseList.length; i++) {
      List<ExecutionData> executionList =
          await executionService.getExecutions(exerciseList[i], 2, true);
      List<StatType> statTypeList =
          statCalculationModel.compareExecution(executionList);
      factor =
          factor + statCalculationModel.getExerciseTrend(statTypeList, false);
    }
    return factor;
  }
}
