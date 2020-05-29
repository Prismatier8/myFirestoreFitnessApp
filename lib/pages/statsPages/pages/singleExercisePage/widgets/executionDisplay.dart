import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/globalWidgets/exerciseImage.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/widgets/singleExerciseWithStats.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/statsPages/provider/singleStatCalculationModel.dart';

enum _TableType { withStats, noStats }

class ExecutionDisplay extends StatelessWidget {
  final List<StatType> statTypeList;
  final List<ExecutionData> executionList;
  final bool isComparable;
  final ExerciseModel exercise;
  ExecutionDisplay(
      {@required this.statTypeList,
      @required this.executionList,
      @required this.isComparable,
      @required this.exercise});

  @override
  Widget build(BuildContext context) {
    return isComparable
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SingleExerciseWithStats(
                exercise: exercise,
                statTypeList: statTypeList,
              ),
              _getDate(0),
              DataTable(
                  columns: _getDataColumns(_TableType.withStats),
                  rows: _constructDataRows(
                      executionList[0], _TableType.withStats)),
              _getDate(1),
              DataTable(
                columns: _getDataColumns(_TableType.noStats),
                rows: _constructDataRows(executionList[1], _TableType.noStats),
              ),
            ],
          )
        : Column(
            children: <Widget>[
              SingleExerciseWithStats(
                exercise: exercise,
                statTypeList: statTypeList,
              ),
              _getDate(0),
              DataTable(
                columns: _getDataColumns(_TableType.noStats),
                rows: _constructDataRows(executionList[0], _TableType.noStats),
              ),
            ],
          );
  }

  Widget _getDate(int index) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(executionList[index].date.toDate().day.toString() +
            "." +
            executionList[index].date.toDate().month.toString() +
            "." +
            executionList[index].date.toDate().year.toString()),
      ),
    );
  }

  List<DataColumn> _getDataColumns(_TableType type) {
    if (type == _TableType.withStats) {
      return [
        DataColumn(label: Text("Satz")),
        DataColumn(label: Text("Gewicht")),
        DataColumn(label: Text("Wiederholungen")),
        DataColumn(label: Text("Tendenz")),
      ];
    } else {
      return [
        DataColumn(label: Text("Satz")),
        DataColumn(label: Text("Gewicht")),
        DataColumn(label: Text("Wiederholungen")),
      ];
    }
  }
  List<DataRow> _constructDataRows(ExecutionData execution, _TableType type) {
    List<DataRow> dataRowList = [];

    for (int i = 0; i < execution.setMap.length; i++) {
      DataRow row = DataRow(cells: _getCells(i, type, execution));
      dataRowList.add(row);
    }
    return dataRowList;
  }
  List<DataCell> _getCells(
      int index, _TableType type, ExecutionData execution) {
    List<String> keyList = execution.setMap.keys.toList();
    keyList.sort();
    List<DataCell> cellList = [
      DataCell(
        Center(child: Text((index + 1).toString())),
      ),

      ///Weight
      DataCell(
        Center(
            child:
                Text(execution.setMap[keyList[index]][0].toString() + " Kg")),

        ///[0] is always weight inside the list
      ),

      ///Repetition
      DataCell(
        Center(child: Text(execution.setMap[keyList[index]][1].toString())),

        ///[1] is always repetition inside the list
      ),
    ];
    if (type == _TableType.withStats)
      cellList.add(DataCell(_getStatIcon(index)));
    return cellList;
  }

  Widget _getStatIcon(int index) {
    if (statTypeList[index] == StatType.same) {
      return Center(
          child: Icon(
        Icons.trending_flat,
        color: Colors.black,
      ));
    } else if (statTypeList[index] == StatType.increase) {
      return Center(child: Icon(Icons.trending_up, color: Colors.green));
    } else {
      return Center(
          child: Icon(
        Icons.trending_down,
        color: Colors.red,
      ));
    }
  }
}
