import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';

class BreakPause extends StatefulWidget {
  final PlanModel planModel;
  BreakPause(this.planModel);
  @override
  _BreakPauseState createState() => _BreakPauseState();
}

class _BreakPauseState extends State<BreakPause> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.hourglass_empty,
            size: 40,
          ),
          Text(
            widget.planModel.breakPause.toString(),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
