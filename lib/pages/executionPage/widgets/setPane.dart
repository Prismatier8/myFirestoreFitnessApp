import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/repetitionDisplay.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'package:myfitnessmotivation/globalWidgets/weightDisplay.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseButton.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:provider/provider.dart';

enum RowType { repetition, weight }

class SetPane extends StatefulWidget {
  final PlanModel planModel;
  final double upperTopHeight;
  SetPane(this.planModel, this.upperTopHeight);
  @override
  _SetPaneState createState() => _SetPaneState();
}

class _SetPaneState extends State<SetPane> {
  bool isInitiated = false;

  @override
  void initState(){
    initExecutionModel().then((value){
      setState(() {
        isInitiated = true;
      });
    });
    super.initState();
  }
  Future initExecutionModel() async {
    final execution = Provider.of<ExecutionModel>(context, listen: false);
    await execution.init(widget.planModel);
  }
  final textSize = 20.0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ExecutionModel>(
      builder: (context, execution, _) {
        return isInitiated ? Container(
          height: _getHeight(context),
          child: Stack(
            children: <Widget>[
              Column(
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
                  WeightDisplay(execution.getCurrentSet(), execution.getCurrentSet().id),
                  RepetitionDisplay(execution.getCurrentSet(), execution.getCurrentSet().id),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BreakPauseButton(
                  planModel: widget.planModel,
                ),
              ),
            ],
          ),
        ) : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  ///calculates the maximum possible height for the set pane based on phone height and height of detail pane
  double _getHeight(BuildContext context){
    final fullPhoneHeight = MediaQuery.of(context).size.height;
    final detailPaneHeight = widget.upperTopHeight;
    return fullPhoneHeight - detailPaneHeight;
  }
}
