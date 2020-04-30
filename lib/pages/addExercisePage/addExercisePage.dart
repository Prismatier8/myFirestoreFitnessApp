import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/addExercisePage/widgets/addExercisePane.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class AddExercisePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Names.NAVIGATION_ADDEXERCISES,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: AddExercisePane(),
    );
  }

}