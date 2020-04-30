import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/globalWidgets/addSetQuantityWidget.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/addPlanInputText.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

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
    return AlertDialog(
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
            AddPlanInputText(controller: _controller, isTitleMissing: isTitleMissing),
            AddSetQuantityWidget(),
          ],
        ),
      ),
    );
  }
}
