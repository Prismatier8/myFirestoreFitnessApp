import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseTimer.dart';
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
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ExecutionTimer(),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 30),
                  child: BreakPauseTimer(widget.planModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  double _getBodySizeHeight(){
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return (maxHeight - statusBarHeight) / 3.2;
  }
}
