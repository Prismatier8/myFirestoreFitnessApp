import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/exerciseModel.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/widgets/executionDisplay.dart';
import 'package:myfitnessmotivation/pages/statsPages/pages/singleExercisePage/widgets/singleExerciseWithStats.dart';
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
          List<StatType> statTypeList  = statCalculationModel.compareExecution(snapshot.data);
          if(snapshot.data.length >= 2){
            return ExecutionDisplay(
              executionList: snapshot.data,
              statTypeList: statTypeList,
              isComparable: true,
              exercise: widget.exercise,
            );

          } else if(snapshot.data.length == 0){
            return Column(
              children: <Widget>[
                SingleExerciseWithStats(
                  statTypeList: statTypeList,
                  exercise: widget.exercise,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text("Keine Daten vorhanden",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],

            );

          } else {
            return ExecutionDisplay(
                executionList: snapshot.data,
                statTypeList: statTypeList,
                isComparable: false,
            );
          }
        } else if (snapshot.hasError){
          return Text("Etwas lief schief, lade die Seite neu",
            style: TextStyle(
              fontSize: 30,
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}
