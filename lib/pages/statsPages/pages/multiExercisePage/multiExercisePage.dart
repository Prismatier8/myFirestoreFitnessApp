import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/multiExercisePage/widgets/exerciseWithStats.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class MultiExercisePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final exerciseService =
    Provider.of<ExerciseService>(context, listen: false);
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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top,
          child: FutureBuilder(
            future: exerciseService.getExercisesFromPlan(plan),
            builder: (BuildContext context, AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot){
              if(exerciseSnapshot.hasData){
                if(exerciseSnapshot.data.length == 0){
                  return Center(
                    child: Container(
                      child: Text("Keine Übungen vorhanden",
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: exerciseSnapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    return ExerciseWithStats(
                        plan: plan,
                        exercisesSnapshot: exerciseSnapshot,
                        builderIndex: index,
                      );
                  },
                );
              } else if(exerciseSnapshot.hasError){
                return Center(
                  child: Text(Names.BASIC_ERRORMESSAGE,
                  style: TextStyle(
                    fontSize: 35,
                  ),),
                );
              }
              else{
                return Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(

                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
