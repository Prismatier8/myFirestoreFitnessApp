import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/widgets/choosableExercise.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class ChooseExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;
    final ExerciseService exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.TITLE_CHOOSEEXERCISES,
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: exerciseService.getDocumentsByStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return ChoosableExercise(
                  planModel: planModel,
                  exerciseModel: ExerciseModel.fromJson(
                      snapshot.data.documents[index].data),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Snapshoterror has occured in StreamBuilderwidget"), //TODO: Need to be watched at the end
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
