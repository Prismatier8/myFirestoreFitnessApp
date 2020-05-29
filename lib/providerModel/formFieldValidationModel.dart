import 'package:flutter/cupertino.dart';

class FormFieldValidationModel extends ChangeNotifier{

  String currentPlanName = "";
  String currentExerciseName = "";
  bool exerciseExist = false;
  bool planExist = false;


  clear(){
    exerciseExist = false;
    planExist = false;
    currentPlanName = "";
    currentExerciseName = "";
  }
}