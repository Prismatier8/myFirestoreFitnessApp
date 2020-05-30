import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/trainingPage/Widgets/cancelButton.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class DeletePlanDialog extends StatelessWidget {
  final PlanModel plan;
  DeletePlanDialog(this.plan);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(plan.title + " löschen?"),
        actions: <Widget>[
      CancelButton(),
      ///DeleteButton
      FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).accentColor,
        onPressed: () {
          _deletePlan(context);
          _deleteExecutionsOnPlan(context);
          Navigator.pop(context);
        },
        child: Text(
          Names.BASIC_DELETE,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ]);
  }

  _deletePlan(BuildContext context) {
    final planService = Provider.of<PlanService>(context, listen: false);
    planService.deletePlan(plan.title);
  }
  _deleteExecutionsOnPlan(BuildContext context){
    final executionService = Provider.of<ExecutionService>(context, listen: false);
    executionService.deleteExecutionByPlan(plan.title);
  }
}
