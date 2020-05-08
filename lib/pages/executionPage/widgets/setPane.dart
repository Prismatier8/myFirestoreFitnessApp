import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/executionData.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/dataModel/setModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionInputRow.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:myfitnessmotivation/services/executionService.dart';
import 'package:myfitnessmotivation/services/setService.dart';
import 'package:provider/provider.dart';

enum RowType {repetition, weight}
class SetPane extends StatefulWidget {
  final PlanModel planModel;
  SetPane(this.planModel);
  @override
  _SetPaneState createState() => _SetPaneState();
}

class _SetPaneState extends State<SetPane> {
   
  TextEditingController _kgController;
   TextEditingController _wdhController;
   SetModel _oldSet;
   @override
  void initState() {
     final execution = Provider.of<ExecutionModel>(context, listen: false);
     execution.init(widget.planModel);
     _kgController = TextEditingController();
     _wdhController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _kgController.dispose();
    _wdhController.dispose();
  }

  final textSize = 20.0;
  @override
  Widget build(BuildContext context) {

    final setService = Provider.of<SetService>(context, listen: false);
    final executionService = Provider.of<ExecutionService>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: _getBodySizeHeight(),
      child: Consumer<ExecutionModel>(
        builder: (context, execution, _) {
          _updateSet(execution, setService);
          _addExecution(execution, executionService, setService);
          _addSetValues(execution);
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Satz ${execution.getCurrentSetIndex()}/${execution.maxSetLength}",
                      style: TextStyle(
                        fontSize: textSize,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${execution.currentExerciseName}",
                      style: TextStyle(
                        fontSize: textSize,
                      ),
                    ),
                  ],
                ),
              ),
              ExecutionInputRow(
                type: RowType.weight,
                textSize: textSize,
                controller: _kgController,
              ),
              ExecutionInputRow(
                type: RowType.repetition,
                textSize: textSize,
                controller: _wdhController,
              ),
            ],
          );
        },
      ),
    );
  }
  _addSetValues(ExecutionModel execution){
    if(execution.getCurrentSet() != null){
      _oldSet = execution.getCurrentSet();
      _kgController.text = execution.getCurrentSet().weight.toString();
      _wdhController.text = execution.getCurrentSet().repetition.toString();
    }
  }
  _updateSet(ExecutionModel execution, SetService setService){
    if(_kgController.text != "" && !execution.isFinished){
      Map<String, dynamic> map = {
        "weight" : double.parse(_kgController.text),
        "repetition" : int.parse(_wdhController.text)};
      setService.updateSet(_oldSet.id, map);
    }
  }
  _addExecution( ExecutionModel execution, ExecutionService executionService, SetService setService) async{
    if(_kgController.text != "" && !execution.isFinished){

        final executionData = await _constructExecution(setService);
        executionService.addExecution(executionData);
    }
  }
  Future<ExecutionData> _constructExecution(SetService setService) async{
    SetModel set = await setService.getSetByID(_oldSet.id);
    ExecutionData executionData = ExecutionData(
        repetition: set.repetition,
        weight: set.weight,
        planRef: widget.planModel.title,
        exerciseRef: set.exerciseRef);
    return executionData;
  }
  double _getBodySizeHeight() {
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final heightFactor = 2.5;

    return (maxHeight - statusBarHeight) / heightFactor;
  }
}
