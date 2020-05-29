import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/breakPause.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/draggableExercise.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/reorderableList.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class PreparationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
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
                onPressed: () async {
                  final planService = Provider.of<PlanService>(context, listen: false);
                  await planService.getPlan(planModel.title) ///refresh plan so that navigated page has updated plan
                      .then((value){
                    PlanModel refreshedModel = PlanModel.fromMap(value.data);
                    Navigator.pushNamedAndRemoveUntil(context, NamedRoutes.ROUTE_EXECUTIONPAGE,(_) => false,
                        arguments: refreshedModel);
                  }).catchError((onError){
                    final snackBar = SnackBar(content: Text(Names.BASIC_ERRORMESSAGE),);
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
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
}
