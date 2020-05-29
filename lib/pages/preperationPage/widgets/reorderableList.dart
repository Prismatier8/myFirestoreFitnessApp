import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/draggableExercise.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class ReorderableList extends StatefulWidget {
  final PlanModel planModel;
  ReorderableList(this.planModel);
  @override
  _ReordableListState createState() => _ReordableListState();
}

class _ReordableListState extends State<ReorderableList> {
  List<ExerciseModel> exerciseList = [];

  @override
  Widget build(BuildContext context) {
    final planService = Provider.of<PlanService>(context);
    final exerciseService = Provider.of<ExerciseService>(context);
    return FutureBuilder(
      future: exerciseService.getExercisesFromPlan(widget.planModel),
      builder: (context, AsyncSnapshot<List<ExerciseModel>> snapshots) {
        if (snapshots.hasData) {
            exerciseList = snapshots.data;

          return Container(
            child: ReorderableListView(
              header: snapshots.data.isEmpty
                  ? Text(
                      "Füge noch Übungen hinzu",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  : Container(),
              onReorder: (int oldIndex, int newIndex) {
                setState (
                  ()  {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }

                    final ExerciseModel item = exerciseList.removeAt(oldIndex);
                    exerciseList.insert(newIndex, item);
                    List<String> exerciseIDList =
                        _transformList(exerciseService);
                    planService.addExerciseToPlan(widget.planModel.title,
                        {"exerciseRef": exerciseIDList});
                  },
                );
              },
              scrollDirection: Axis.vertical,
              children: List.generate(
                exerciseList.length,
                (index) {
                  return DraggableExercise(
                    exerciseList[index],
                    Key('$index'),
                  );
                },
              ),
            ),
          );
        } else if (snapshots.hasError){
          return Center(
            child: Text(Names.BASIC_ERRORMESSAGE,
              style: TextStyle(
                fontSize: 40
              ),
            ),
          );

        } else {
          return Center(
            child: Container(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
              ),
            ),
          );
        }
      },
    );
  }

  ///To save the new exerciseSequence of a plan it is necessary to transform the exerciseList that
  ///contains ExerciseModels into a List of Strings that contains the title of the exercise which
  ///can be identified as the id of the document inside the exercise collection
  List<String> _transformList(exerciseService) {
    List<String> exerciseIDList = [];
    for (int i = 0; i < exerciseList.length; i++) {
      exerciseIDList.add(exerciseList[i].title);
    }
    return exerciseIDList;
  }
}
