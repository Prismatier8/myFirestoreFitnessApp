import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionInputRow.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
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
    final executionModel = Provider.of<ExecutionModel>(context, listen: false);
    executionModel.init(widget.planModel);
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
      width: MediaQuery.of(context).size.width * 0.9,
      height: _getBodySizeHeight(),
      child: Card(
        child: Consumer<ExecutionModel>(
          builder: (context, executionModel, _) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Satz ${executionModel.getCurrentSetIndex()}/${executionModel.maxSetLength}",
                        style: TextStyle(
                          fontSize: textSize,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${executionModel.currentExerciseName}",
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
      ),
    );
  }

  double _getBodySizeHeight() {
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final heightFactor = 2.5;

    return (maxHeight - statusBarHeight) / heightFactor;
  }
}
