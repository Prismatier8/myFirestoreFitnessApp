import 'package:flutter/cupertino.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';

enum StatType {increase, decrease, same}

class SingleStatCalculationModel extends ChangeNotifier {



  List<StatType> compareExecution(List<ExecutionData> executionList){
    List<StatType> statTypeList = [];
    if(executionList.length == 2){
      statTypeList = _prepareMaps(executionList[0].setMap, executionList[1].setMap);

    }
    return statTypeList;

    ///MULTICOMPARISON for history -> CURRENTLY NOT FINISHED and Error prone
    /*
    for(int i = 0; i<executionList.length; i++){
      if(executionList.length - 1 <= i + 1){
        List<StatType> statDataList = _prepareMaps(executionList[i].setMap, executionList[i + 1].setMap);
      }
    }
    return
    */

  }
  ///this function prepares the latest execution and the second execution and fetches
  ///the needed values out of the maps. Basically the preperation before
  ///calculation
  List<StatType> _prepareMaps(Map<String, dynamic> newExecution, Map<String, dynamic> olderExecution){
        List<StatType> setTypeList = [];
        List<String> newKeyList = newExecution.keys;
        List<String> olderKeyList = olderExecution.keys;

        ///Set iteration
    for(int i = 0; i<newExecution.length; i++){

      double newWeight = newExecution[newKeyList[i]][0]; ///weight is always at index 0
      int newRepetition = newExecution[newKeyList[i]][1]; ///repetition is always at index 1

      double olderWeight = olderExecution[olderKeyList[i]][0];
      int olderRepetition = olderExecution[olderKeyList[i]][1];



        ///per set calculation
      StatType type = _calculate(newWeight, olderWeight, newRepetition, olderRepetition);
      setTypeList.add(type);
    }
    return setTypeList;
  }
  ///Calculates the factor by comparing both weight and repetition values from
  ///the latest set and the secondlatest set
   StatType _calculate(double newWeight, double olderWeight,
      int newRepetition, int olderRepetition){

    ///only increasements and decreasements will change the factor
    int factor = 0;

    if(newWeight > olderWeight){

      factor = factor + _calculatePercentage(newWeight, olderWeight);

    } else if (newWeight < olderWeight){

      factor = factor - _calculatePercentage(newWeight, olderWeight);

    }
    if(newRepetition > olderRepetition){

      factor = factor + _calculatePercentage(newRepetition, olderRepetition);

    } else if (newRepetition < olderRepetition) {

      factor = factor - _calculatePercentage(newRepetition, olderRepetition);

    }
    return _checkStatType(factor);
  }
  ///Returns the StatType by checking the end result of the factor.
  StatType _checkStatType(int factor){
    if(factor == 0){
      return StatType.same;
    } else if (factor > 0){
      return StatType.increase;
    } else {
      return StatType.decrease;
    }
  }
  ///Calculates the percentage of increasement or decreasement by comparing
  ///the value of the latest set and the secondlatest set
  int _calculatePercentage(num newValue, num olderValue){
    int percentage = 0;
    double decreasement = 0.0;
    decreasement = (newValue - olderValue) / olderValue;
    percentage = (decreasement * 100).round();
    return percentage;
  }
}