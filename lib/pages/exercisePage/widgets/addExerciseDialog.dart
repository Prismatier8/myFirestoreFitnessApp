import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/exercisePage/widgets/setQuantityWidget.dart';
import 'package:myfitnessmotivation/globalWidgets/listenableTextField.dart';
import 'package:myfitnessmotivation/providerModel/formFieldValidationModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/exercisePage/provider/setQuantityModel.dart';
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
  final _formKey = GlobalKey<FormState>();
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
            Provider.of<FormFieldValidationModel>(context, listen: false).clear(); ///clear state because exercise adding process is over
            _clearSetQuantity(setQuantityModel); /// same reason as above
            Navigator.pop(context);
          },
          child: Text(
            Names.BASIC_CANCELBUTTON,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ///AddButton
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          onPressed: () async{
            final exerciseService = Provider
                .of<ExerciseService>(context, listen: false);
            final val = Provider
                .of<FormFieldValidationModel>(context, listen: false);
            val.exerciseExist = await exerciseService
                .validateExerciseName(val.currentExerciseName);
            if(_formKey.currentState.validate()){

              _addExerciseToDB(setQuantityModel);
              val.clear(); ///clear validation process
              _clearSetQuantity(setQuantityModel); ///clear state because exercise adding process is over
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
                Names.TITLE_ADDEXERCISE,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Form(
              key: _formKey,
              child: ListenableTextField(
                type: TextFieldType.exercise,
                  controller: _controller,
                  isTitleMissing: isTitleMissing),
            ),

            SetQuantityWidget(),
          ],
        ),
      ),

    );
  }
  ///Adds an exercise to firestore in collection: "exercises" as a document. At this time the exercise document wont have
  ///any references to sets that are added shortly after, which will be processed as soon as the exercise is added to firestore.
  _addExerciseToDB(SetQuantityModel setQuantityModel){
    final exerciseService = Provider.of<ExerciseService>(context, listen: false);
    final setService = Provider.of<SetService>(context, listen: false);

    ExerciseModel exercise = _constructExercise(setQuantityModel);
    exerciseService.addExercise(exercise, exercise.title);
    _addSetsToDB(setQuantityModel, setService);
    _addSetReferencesToExercise(setService, exerciseService);
  }
  ///This method adds all recently added sets as references to the recently added exercise. The query getReferencedDocument from setService returns
  ///a snapshot of all sets that references the specific exercise. There document ID's will then be added as references to the exercise
  /// by the updateExercise() service.
  _addSetReferencesToExercise(SetService setService, ExerciseService exerciseService) async{
    QuerySnapshot snapshot = await setService.getReferencedDocuments(_controller.text);
    List<String> documentIDList = [];
    for(int i = 0; i<snapshot.documents.length; i++){
      documentIDList.add(snapshot.documents[i].documentID);
    }
    exerciseService.updateExercise(_controller.text, {'setReferences' : documentIDList});
  }
  ///Adds all sets as documents based on the setQuantity into the collection "sets"
  _addSetsToDB(SetQuantityModel setQuantityModel, SetService setService){
    final setList = _constructSets(setQuantityModel);
    setList.forEach((setModel){
      setService.addSet(setModel);
    });
  }
  ///Construct all Sets based on SetQuantity and return a list of sets
  List<SetModel> _constructSets(SetQuantityModel setQuantityModel){
    final double defaultWeight = 10;
    final int defaultRepetition = 10;
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
  ///the setQuantity in the SetQuantityModel must be cleared after the add exercise process is finished or canceled to reset the counter to its
  ///default value. Otherwise the setQuantity will have the number saved that the user have set as last value which is not intended
  _clearSetQuantity(SetQuantityModel model){
    model.clear();
  }
}
