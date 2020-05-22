

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/addExerciseDialog.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/exercise.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';


class ExercisePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.NAVIGATION_EXERCISES,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          heroTag: "addExercise",
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            _showAddExerciseDialog(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: exerciseService.getExercisesByStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index){
                return Exercise(
                  ExerciseModel.fromJson(snapshot.data.documents[index].data)
                );
              },
            );
          }else if (snapshot.hasError){
            print("snapshoterror caused on exercisePage when loading exercises from firestore"); //TODO: Look into it in the end
            return Container();
          }else{
           return CircularProgressIndicator();
          }
        },
      ),
    );
  }
  _showAddExerciseDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AddExerciseDialog();
        });
  }
}