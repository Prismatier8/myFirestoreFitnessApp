import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseButton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionInputRow.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
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
    return Container(
      child: Consumer<ExecutionModel>(
        builder: (context, execution, _) {
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
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: BreakPauseButton(
                  planModel: widget.planModel,
                  kgController: _kgController,
                  wdhController: _wdhController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  _addSetValues(ExecutionModel execution){
    if(execution.getCurrentSet() != null){
      _kgController.text = execution.getCurrentSet().weight.toString();
      _wdhController.text = execution.getCurrentSet().repetition.toString();
    }
  }
}
