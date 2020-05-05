import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:provider/provider.dart';

class BreakPauseTimer extends StatefulWidget {

  @override
  _BreakPauseTimerState createState() => _BreakPauseTimerState();
}

class _BreakPauseTimerState extends State<BreakPauseTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.hourglass_empty,
            size: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Consumer<BreakPauseModel>(
              builder: (context, breakPause, _){
                  return Text(
                    breakPause.currentBreakPause.toString() + " s",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
