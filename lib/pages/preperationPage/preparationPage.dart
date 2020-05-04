import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/breakPause.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/draggableExercise.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/reorderableList.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class PreparationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;
    final exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    final planService = Provider.of<PlanService>(context, listen: false);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  _deletePlan(planService, planModel);

                },
                child: Icon(
                  Icons.delete,
                  size: 30,
                ),
              )),
        ],
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          planModel.title,
          style: TextStyle(fontSize: 28),
        ),
      ),
      floatingActionButton: planModel.exerciseRef.isNotEmpty
          ? SizedBox(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                heroTag: Names.HEROTAG_FLOATINGBUTTON,
                onPressed: () {
                  Navigator.pushNamed(context, NamedRoutes.ROUTE_EXECUTIONPAGE,
                      arguments: planModel);
                },
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
              ),
            )
          : Container(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: BreakPause(planModel),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: ReorderableList(planModel),
          ),
        ],
      ),
    );
  }
  _deletePlan(PlanService planService, PlanModel plan){
    planService.deletePlan(plan.title);
  }
}
