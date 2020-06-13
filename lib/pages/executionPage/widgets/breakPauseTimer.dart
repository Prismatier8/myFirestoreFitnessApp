import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/breakPauseModel.dart';
import 'package:provider/provider.dart';

class BreakPauseTimer extends StatefulWidget {
  final PlanModel planModel;
  BreakPauseTimer(this.planModel);
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
            child: Consumer<BreakPauseModel>(builder: (context, breakPause, _) {
              //_vibrate(breakPause);
              //_playLocalAsset(breakPause);
              return Text(
                breakPause.currentBreakPause.toString() + " s",
                style: TextStyle(
                  fontSize: 25,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  /*
  _vibrate(BreakPauseModel breakPause) async {
    if(widget.planModel.vibrationSignal == true){
      final int vibrationLength = 2000;
      if (await Vibration.hasVibrator()) {
        if (_isBreakPauseEndReached(breakPause)) {
          Vibration.vibrate(duration: vibrationLength);
        }
      }
    }
  }

  Future<AudioPlayer> _playLocalAsset(BreakPauseModel breakPause) async {

    if(widget.planModel.audioSignal == true){
      if (_isBreakPauseEndReached(breakPause)) {
        AudioCache cache = new AudioCache();
        return await cache.play("impact.wav");
      } else
        return null;
    }
    return null;
  }

  bool _isBreakPauseEndReached(BreakPauseModel breakPause){
    if(breakPause.currentBreakPause == 1){
      return true;
    }
    else{
      return false;
    }
  }
   */

}
