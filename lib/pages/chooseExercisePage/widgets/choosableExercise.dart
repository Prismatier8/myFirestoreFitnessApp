import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:provider/provider.dart';

class ChoosableExercise extends StatefulWidget {
  final PlanModel planModel;
  final ExerciseModel exerciseModel;
  ChoosableExercise({@required this.planModel, @required this.exerciseModel});
  @override
  _ChoosableExerciseState createState() => _ChoosableExerciseState();
}

class _ChoosableExerciseState extends State<ChoosableExercise> {

  @override
  Widget build(BuildContext context) {
    final planService = Provider.of<PlanService>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                widget.exerciseModel.title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
            FutureBuilder(
              future: planService.getPlan(widget.planModel.title),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  return Padding(
                    padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () async{
                        await _setupExecution(planService, snapshot);
                        setState(() {
                        });
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(

                            shape: BoxShape.circle,
                          ),
                          child: checkForContainingReference(snapshot)
                              ? Icon(Icons.remove, color: Colors.red, size: 40)
                              : Icon(Icons.add, color:Colors.green, size: 40)
                      ),
                    ),
                  );
                }
                else if(snapshot.hasError){
                  return Text("Error"); //TODO: Need to be watched at the end
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  ///simple check if the selected plan has reference to the selected exercise
  bool checkForContainingReference(AsyncSnapshot<DocumentSnapshot> snapshot){
    final planModel = PlanModel.fromMap(snapshot.data.data);
    if(planModel.exerciseRef.contains(widget.exerciseModel.title)){
      return true;
    }
    else{
      return false;
    }
  }
  ///This Method is doing all necessary steps before the main reference adding or removing process starts. The ID to the exercise document has to be inside a list. To know to
  ///which plan it has to be added it is needed to instantiate a planModel of the current selected plan.
  _setupExecution(planService, AsyncSnapshot<DocumentSnapshot> snapshot) async {

    final planModel = PlanModel.fromMap(snapshot.data.data);
    List<String> exerciseID = [];
    exerciseID.add(widget.exerciseModel.title);
    _chooseExercise(planModel, planService, exerciseID);
  }
  ///The method checks if a plan document has already an existing reference to the exercise we want to add. Depending on the result, it will add a new reference to the array
  ///or remove the existing reference. Please remind, that the FieldValue.arrayRemove/arrayUnion needs a List instead of a single value.
  _chooseExercise(PlanModel planModel, planService, List<String> exerciseID){
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);

    if(planModel.exerciseRef.contains(widget.exerciseModel.title)){
      exerciseService.deletePlanFromExercise(widget.exerciseModel.title, planModel.title);
      planService.addExerciseToPlan(widget.planModel.title, {"exerciseRef" : FieldValue.arrayRemove(exerciseID)});
    }else {
      exerciseService.addPlanToExercise(widget.exerciseModel.title, planModel.title);
      planService.addExerciseToPlan(widget.planModel.title, {"exerciseRef" : FieldValue.arrayUnion(exerciseID)});
    }
  }

}
