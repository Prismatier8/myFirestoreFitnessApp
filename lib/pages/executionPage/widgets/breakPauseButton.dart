import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';

class BreakPauseButton extends StatefulWidget {
  final PlanModel planModel;
  final TextEditingController kgController;
  final TextEditingController wdhController;
  BreakPauseButton(
      {@required this.planModel,
      @required this.kgController,
      @required this.wdhController});
  @override
  _BreakPauseButtonState createState() => _BreakPauseButtonState();
}

class _BreakPauseButtonState extends State<BreakPauseButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bool showFAB = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return showFAB
        ? Padding(
            padding: EdgeInsets.only(bottom: 45),
            child: GestureDetector(
              onTapDown: _animationOnTapDown,
              child: Transform.scale(
                scale: 1 - _controller.value,
                child: SizedBox(
                  height: 130,
                  width: 130,
                  child: FloatingActionButton(
                    backgroundColor: Colors.lightBlueAccent,
                    heroTag: Names.HEROTAG_FLOATINGBUTTON,
                    elevation: 10,
                    onPressed: () {
                      _onPress();
                    },
                    child: Icon(
                      Icons.hourglass_empty,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
  ///When the user presses the button for the first time, the timer will be started inside the executionPage
  ///As soon as the user hits the button again, the timer will reset based on the breakPause time set in the
  ///firestore document for that specific plan.
  ///Additionally the user will start the next set or exercise when touched
  _onPress() {
    HapticFeedback.vibrate();
    final execution = Provider.of<ExecutionModel>(context, listen: false);
    final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
    if (breakPause.isTimerActive == false && !execution.isFinished) {
      execution.nextSet(widget.wdhController.text, widget.kgController.text);
      breakPause.start();
    } else {
      breakPause.stop();
    }
  }

  _animationOnTapDown(TapDownDetails details) {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }
}
