import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/globalWidgets/setQuantityWidget.dart';
import 'package:myfitnessmotivation/globalWidgets/listenableTextField.dart';
import 'package:myfitnessmotivation/providerModel/setQuantityModel.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class AddExerciseDialog extends StatefulWidget {
  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  TextEditingController _controller;
  bool isTitleMissing = false;
  @override
  void initState() {

    super.initState();
    _controller = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final setQuantityModel = Provider.of<SetQuantityModel>(context);
    return AlertDialog(
      actions: <Widget>[
        ///Cancel Button
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {

            _clearSetQuantity(setQuantityModel);
            Navigator.pop(context);
          },
          child: Text(
            Names.ADDPLAN_CANCELBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ///AddButton
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () {

             if (_checkMissingTitle()) {
              setState(() {
                isTitleMissing = true;
              });
            } else {
               _addExerciseToDB(setQuantityModel);
              _clearSetQuantity(setQuantityModel);
              Navigator.pop(context);
            }
          },
          child: Text(
            Names.ADDPLAN_ADDBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      content: Container(
        height: 250,
        width: 300,
        child: Column(
          children: <Widget>[
            Center(

              child: Text(
                Names.ADDEXERCISE_TITLE,
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListenableTextField(controller: _controller, isTitleMissing: isTitleMissing),
            SetQuantityWidget(),
          ],
        ),
      ),

    );
  }
  ///Adds an exercise to firestore in collection: "exercises" as a document at this time, the exercise document wont have
  ///any references to sets
  _addExerciseToDB(SetQuantityModel setQuantityModel){
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    final setService = Provider.of<SetService>(context, listen: false);

    ExerciseModel exercise = _constructExercise(setQuantityModel);
    exerciseService.addExercise(exercise, exercise.title);
    _addSetsToDB(setQuantityModel, setService);
    _addSetReferencesToExercise(setService, exerciseService);
  }
  _addSetReferencesToExercise(SetService setService, ExerciseService exerciseService) async{
    QuerySnapshot snapshot = await setService.getReferencedDocuments(_controller.text);
    List<String> documentIDList = [];
    for(int i = 0; i<snapshot.documents.length; i++){
      documentIDList.add(snapshot.documents[i].documentID);
    }
    exerciseService.updateExercise(_controller.text, {'setReferences' : documentIDList});
  }
  _addSetsToDB(SetQuantityModel setQuantityModel, SetService setService){
    final setList = _constructSets(setQuantityModel);
    setList.forEach((setModel){
      setService.addSet(setModel);
    });
  }
  ///Construct all Sets based on SetQuantity
  List<SetModel> _constructSets(SetQuantityModel setQuantityModel){
    double defaultWeight = 10;
    int defaultRepetition = 10;
    List<SetModel> setList = [];
    for(int i = 0; i<setQuantityModel.setQuantity; i++){
      setList.add(SetModel(
        weight: defaultWeight,
        repetition: defaultRepetition,
        sequence: i + 1, //to start at Sequence 1 rather then 0
        exerciseRef: _controller.text,
      ));
    }
    return setList;
  }
  ///Construct Exercise based on userinput for title and setQuantity
  ExerciseModel _constructExercise(SetQuantityModel setQuantityModel){
      return ExerciseModel(
        title: _controller.text,
        setQuantity: setQuantityModel.setQuantity,
        setReferences: [],
      );
  }
  bool _checkMissingTitle() {
    return _controller.text.isEmpty;
  }
  _clearSetQuantity(SetQuantityModel model){
    model.clear();
  }
}
