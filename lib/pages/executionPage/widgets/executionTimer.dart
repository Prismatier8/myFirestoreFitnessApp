import 'dart:async';

import 'package:flutter/material.dart';

class ExecutionTimer extends StatefulWidget {
  @override
  _ExecutionTimerState createState() => _ExecutionTimerState();
}

class _ExecutionTimerState extends State<ExecutionTimer> {
  int _currentSeconds = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t){
      setState(() {
        _currentSeconds++;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.access_time,
            size: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              _getMinute(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMinute() {
    double minutes = _currentSeconds / 60;
    return minutes.round().toString() + " Min.";
  }
}
