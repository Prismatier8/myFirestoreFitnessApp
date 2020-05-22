import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/muscleGroupModel.dart';
import 'package:myfitnessmotivation/pages/updateExercisePage/widgets/muscleRow.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/muscleGroupService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class MuscleGroupDialog extends StatelessWidget {
  final ExerciseModel exercise;
  MuscleGroupDialog(this.exercise);
  @override
  Widget build(BuildContext context) {
    final muscleService =
        Provider.of<MuscleGroupService>(context, listen: false);
    final exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            Names.BASIC_ACCEPT,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      title: Center(child: Text("Muskelgruppen")),
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: 200,
          child: StreamBuilder(
            stream: muscleService.getMuscleGroupsByStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> muscleSnapshot) {
              if (muscleSnapshot.hasData) {
                return FutureBuilder(
                  future: exerciseService.getExerciseData(exercise.title),
                  builder: (BuildContext context,
                      AsyncSnapshot<ExerciseModel> exerciseSnapshot) {
                    if (exerciseSnapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: muscleSnapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MuscleRow(
                            muscleGroupModel: MuscleGroupModel.fromMap(
                                muscleSnapshot.data.documents[index].data),
                            exercise: exerciseSnapshot.data,
                          );
                        },
                      );
                    } else if (exerciseSnapshot.hasError) {
                      return Center(
                        child: Text("Verbindungsfehler"),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              } else if (muscleSnapshot.hasError) {
                return Center(
                  child: Text("Verbindungsfehler"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
