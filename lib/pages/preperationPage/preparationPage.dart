import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/draggableExercise.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/reorderableList.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class PreparationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;
    final exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.TITLE_PREPERATION,
          style: TextStyle(fontSize: 28),
        ),
      ),
      floatingActionButton: planModel.exerciseRef.isNotEmpty
          ? SizedBox(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                onPressed: () {
                  //Todo: ExecutionPage
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
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: ReorderableList(planModel),
          ),
        ],
      ),
    );
  }
}
