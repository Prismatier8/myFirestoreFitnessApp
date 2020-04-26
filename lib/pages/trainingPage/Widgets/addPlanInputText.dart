
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/strings.dart';

class AddPlanInputText extends StatefulWidget{
  final TextEditingController controller;
  final bool isTitleMissing;
  AddPlanInputText({@required this.controller, @required this.isTitleMissing});
  _AddPlanInputText createState() => _AddPlanInputText();
}
class _AddPlanInputText extends State<AddPlanInputText>{
  Widget build(BuildContext context){

    return TextField(
      onChanged: (text){
        setState(() {
        });
      },
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: Names.BASIC_TITLE,
          errorText: validateTextInputField()),
      keyboardType: TextInputType.text,
    );
  }
  //displays error message below InputField if user tries to press the add button before providing a plantitle
  String validateTextInputField() {
    if (widget.isTitleMissing && widget.controller.text.isEmpty) {
      return Names.ADDPLAN_TITLEERRORMESSAGE;
    }
    return null;
  }
}