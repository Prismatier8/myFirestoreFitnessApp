import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/providerModel/singleStatCalculationModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:provider/provider.dart';

class StatBuilder extends StatefulWidget {
  final ExerciseModel exercise;
  final int buildLength;
  StatBuilder({@required this.exercise, @required this.buildLength});
  @override
  _StatBuilderState createState() => _StatBuilderState();
}

class _StatBuilderState extends State<StatBuilder> {
  ExecutionService executionService;
  SingleStatCalculationModel statCalculationModel;

  @override
  void initState() {
    executionService =
        Provider.of<ExecutionService>(context, listen: false);
    statCalculationModel =
        Provider.of<SingleStatCalculationModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: executionService.getExecutions(widget.exercise, widget.buildLength, true),
      builder: (context, AsyncSnapshot<List<ExecutionData>> snapshot){
        if(snapshot.hasData){
          List<StatType> list  = statCalculationModel.compareExecution(snapshot.data);
          print(list);
          return Column(
            children: <Widget>[

              ],
          );
        } else{
          return Container();
        }

      }
    );
  }
}
