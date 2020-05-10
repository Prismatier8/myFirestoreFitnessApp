import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseTimer.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cancelExecutionbutton.dart';
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black12,
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Icon(Icons.photo_camera, color: Colors.black38,),
              ),
            ),
          ),
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
