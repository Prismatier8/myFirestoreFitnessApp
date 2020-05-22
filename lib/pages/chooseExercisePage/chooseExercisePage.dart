import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/provider/selectionModel.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/widgets/choosableExercise.dart';
import 'package:myfitnessmotivation/pages/chooseExercisePage/widgets/dropDownSelection.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class ChooseExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlanModel planModel = ModalRoute.of(context).settings.arguments;

    final ExerciseService exerciseService =
        Provider.of<ExerciseService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (context) => SelectionModel(),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            DropDownSelection(),
          ],
          backgroundColor: Theme.of(context).accentColor,
          title: Text(
            Names.TITLE_CHOOSEEXERCISES,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        body: Consumer<SelectionModel>(
          builder: (context, selectionModel, _){
            return FutureBuilder(
              future: exerciseService.getExercisesWithMuscleGroup(selectionModel.currentDropDownSelection),
              builder: (BuildContext context, AsyncSnapshot<List<ExerciseModel>> exerciseSnapshot) {
                if (exerciseSnapshot.hasData) {
                  final planService = Provider.of<PlanService>(context, listen: false);
                  return FutureBuilder(
                    future: planService.getPlan(planModel.title),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> planSnapshot){
                      if(planSnapshot.hasData){
                        return ListView.builder(
                          itemCount: exerciseSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChoosableExercise(
                              planModel: PlanModel.fromMap(planSnapshot.data.data),
                              exerciseData: exerciseSnapshot.data[index],
                            );
                          },
                        );
                      } else if (planSnapshot.hasError) {
                        return Center(
                          child: Text(
                              Names.BASIC_ERRORMESSAGE),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else if (exerciseSnapshot.hasError) {
                  return Center(
                    child: Text(
                        Names.BASIC_ERRORMESSAGE),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
