import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseTimer.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cancelExecutionbutton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cyclingImage.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionTimer.dart';

class DetailPane extends StatefulWidget {
  final PlanModel planModel;
  final double upperTopHeight;
  DetailPane(this.planModel, this.upperTopHeight);
  @override
  _DetailPaneState createState() => _DetailPaneState();
}

class _DetailPaneState extends State<DetailPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff0f0f0),
      width: MediaQuery.of(context).size.width,
      height: widget.upperTopHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CancelExecutionButton(),
                Spacer(),
                ExecutionTimer(widget.planModel),
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
}
