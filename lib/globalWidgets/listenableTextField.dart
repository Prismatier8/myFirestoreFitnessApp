import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/formFieldValidationModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';
enum TextFieldType {plan, exercise}
class ListenableTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isTitleMissing;
  final TextFieldType type;
  ListenableTextField(
      {@required this.controller,
        @required this.isTitleMissing,
      @required this.type});
  _ListenableTextFieldState createState() => _ListenableTextFieldState();
}

class _ListenableTextFieldState extends State<ListenableTextField> {
  Widget build(BuildContext context) {
    final validationModel =
        Provider.of<FormFieldValidationModel>(context, listen: false);
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Bitte Titel angeben";
        }
        if (validationModel.planExist || validationModel.exerciseExist) {
          return "Name bereits vergeben";
        }
        return null;
      },
      onChanged: (text) {
        if(widget.type == TextFieldType.plan){
          validationModel.currentPlanName = text;
        } else {
          validationModel.currentExerciseName = text;
        }
      },
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: Names.BASIC_TITLE),
      keyboardType: TextInputType.text,
    );
  }
}
