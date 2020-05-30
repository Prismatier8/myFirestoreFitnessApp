import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/exercisePage/provider/setQuantityModel.dart';
import 'package:myfitnessmotivation/pages/exercisePage/widgets/setQuantityWidget.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

///currently not in use (not finished)
class UpdateSetQuantityDialog extends StatefulWidget {
  final ExerciseModel exercise;
  UpdateSetQuantityDialog(this.exercise);
  @override
  _UpdateSetQuantityDialogState createState() => _UpdateSetQuantityDialogState();
}
class _UpdateSetQuantityDialogState extends State<UpdateSetQuantityDialog> {

  @override
  Widget build(BuildContext context) {
    final setQuantityModel = Provider.of<SetQuantityModel>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        width: 200,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(Names.BASIC_SETS,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
           SetQuantityWidget(),
          ],
        ),
      ),
      actions: <Widget>[
        ///Cancel Button
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {

            setQuantityModel.clear();
            Navigator.pop(context);
          },
          child: Text(
            Names.BASIC_CANCELBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ///Accept new Value
        FlatButton(
          onPressed: () async{
            await _updateToNewSetQuantity(context, setQuantityModel).then((value){
              setQuantityModel.clear();
              Navigator.pop(context, "success");
            }).catchError((onError){
              setQuantityModel.clear();
              Navigator.pop(context, "no success");
            });
          },
          child: Text(Names.BASIC_ACCEPT,
          style: TextStyle(
            color: Colors.white,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,

        ),
      ],
    );
  }
  ///Update Set quantity of exercise to new user selection
  Future _updateToNewSetQuantity(BuildContext context, SetQuantityModel setQuantityModel) async {
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    final setService = Provider.of<SetService>(context, listen: false);
    ExerciseModel exercise = await exerciseService.getExerciseData(widget.exercise.title); ///refreshed exercise
    if(exercise.setQuantity == setQuantityModel.setQuantity){
      return;
    }
    if(exercise.setQuantity > setQuantityModel.setQuantity){
      await _deleteSets(setService, exercise, setQuantityModel);
      return;
    }
  }
  ///if user selects less sets than before, delete latest sets
  _deleteSets(SetService setService, ExerciseModel exercise, SetQuantityModel setQuantityModel) async {

    for(int i = exercise.setQuantity; i > setQuantityModel.setQuantity; i--){
      await setService.deleteSetsBySequenceAndExercise(exercise.title, i);
    }
  }

}
