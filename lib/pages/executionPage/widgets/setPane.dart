import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseButton.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/globalWidgets/executionInputRow.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:provider/provider.dart';

enum RowType { repetition, weight }

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
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 30, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TitleDisplay(
                      title: "Satz ${execution.getCurrentSetIndex()}/${execution.maxSetLength}",
                      containerWidth: 100,
                      containerHeight: 30,
                    ),
                    Spacer(),
                    TitleDisplay(
                      title: "${execution.currentExerciseName}",
                      containerHeight: 30,
                      containerWidth: MediaQuery.of(context).size.width - 140,
                    ),
                  ],
                ),
              ),
              ExecutionInputRow(
                type: RowType.weight,
                textSize: textSize,
                controller: _kgController,
                isUpdater: false,
              ),
              ExecutionInputRow(
                type: RowType.repetition,
                textSize: textSize,
                controller: _wdhController,
                isUpdater: false,
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

  ///add current set values to controllers. So that the input text shows the currently saved
  ///weight and repetition value
  _addSetValues(ExecutionModel execution) {
    if (execution.getCurrentSet() != null) {
      _kgController.text = execution.getCurrentSet().weight.toString();
      _wdhController.text = execution.getCurrentSet().repetition.toString();
    }
  }
}
