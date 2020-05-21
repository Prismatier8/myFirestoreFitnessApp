import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseTimer.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cancelExecutionbutton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cyclingImage.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionTimer.dart';

class DetailPane extends StatefulWidget {
  final PlanModel planModel;
  DetailPane(this.planModel);
  @override
  _DetailPaneState createState() => _DetailPaneState();
}

class _DetailPaneState extends State<DetailPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0f0f0),
      width: MediaQuery.of(context).size.width,
      height: _getBodySizeHeight(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CancelExecutionButton(),
                Spacer(),
                ExecutionTimer(),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 30),
                  child: BreakPauseTimer(widget.planModel),
                ),
              ],
            ),
          ),
          CyclingImage(),

        ],
      ),
    );
  }

  double _getBodySizeHeight() {
    final heightFactor = 2.5;
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return (maxHeight - statusBarHeight) / heightFactor;
  }
}
