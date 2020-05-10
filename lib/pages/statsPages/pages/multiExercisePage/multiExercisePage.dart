import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class MultiExercisePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context);
    final plan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.TITLE_STATS,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: exerciseService.getExerciseModelsFromPlan(plan),
        builder: (BuildContext context, AsyncSnapshot<List<ExerciseModel>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return Text(snapshot.data[index].title);
              },
            );
          } else if(snapshot.hasError){
            return Container(); //TODO: Watch at the end
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
