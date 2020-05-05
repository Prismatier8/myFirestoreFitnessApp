
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class BreakPauseButton extends StatefulWidget {
  final PlanModel planModel;
  BreakPauseButton(this.planModel);
  @override
  _BreakPauseButtonState createState() => _BreakPauseButtonState();
}

class _BreakPauseButtonState extends State<BreakPauseButton> {

  @override
  void didUpdateWidget(BreakPauseButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: 45),
      child: SizedBox(
        height: 130,
        width: 130,
        child: FloatingActionButton(
          onPressed: () {
            _onPress();
          },
          child: Icon(
            Icons.hourglass_empty,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlueAccent,
          heroTag: Names.HEROTAG_FLOATINGBUTTON,
        ),
      ),
    );
  }

  ///When the user presses the button for the first time, the timer will be started inside the executionPage
  ///As soon as the user hits the button again, the timer will reset based on the breakPause time set in the
  ///firestore document for that specific plan
  _onPress() {
    final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
    if(breakPause.isTimerActive == false){
      breakPause.start();
    }
    else{
      breakPause.stop();
    }

  }
}
