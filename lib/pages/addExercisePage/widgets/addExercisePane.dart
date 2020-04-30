import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class AddExercisePane extends StatefulWidget {
  @override
  _AddExercisePaneState createState() => _AddExercisePaneState();
}

class _AddExercisePaneState extends State<AddExercisePane> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 100),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: Names.BASIC_TITLE,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: () {
              //TODO: Define Tap when user is trying to add muscleGroups to exercise
            },
            child: Text(
              Names.BASIC_MUSCLEGROUPS,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text("The future musclegroups"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: InkWell(
            onTap: (){
              //TODO: Define SetQuantity tap when user is trying to add SetQuantity
            },
            child: Text(
              Names.BASIC_SETS,
              style: TextStyle(fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}
