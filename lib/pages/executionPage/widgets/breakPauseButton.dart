import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/provider/executionTimerModel.dart';
import 'package:myfitnessmotivation/services/muscleGroupService.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/breakPauseModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/executionModel.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';
import 'package:provider/provider.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';



class BreakPauseButton extends StatefulWidget {
  final PlanModel planModel;

  BreakPauseButton(
      {@required this.planModel,});
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

    final bool showFAB = MediaQuery.of(context).viewInsets.bottom == 0.0; ///if keyboard is active, hide Button
    return showFAB
        ? Padding(
            padding: EdgeInsets.only(bottom: 60, top: 10),
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
  _onPress() async {
    HapticFeedback.vibrate();
    try{
      await InternetAddress.lookup("example.com");
      if(await _isDatabaseConnected(context) == false){
        final snackBar = SnackBar(content: Text(Names.BASIC_ERRORMESSAGE));
        Scaffold.of(context).showSnackBar(snackBar);
        return;
      }
      final execution = Provider.of<ExecutionModel>(context, listen: false);
      final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
      if (breakPause.isTimerActive == false && !execution.isFinished) {
        await execution.nextSet();
        if(execution.isFinished){
          _showFinishScreen(context);
          breakPause.stop();
          return;
        }
        breakPause.start();
      }
    }on SocketException catch(_){
      final snackBar = SnackBar(content: Text("Keine Internetverbindung"));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  Future<bool> _isDatabaseConnected(BuildContext context) async{
    final muscleService = Provider.of<MuscleGroupService>(context, listen: false);
    return await muscleService.isConnected();
  }
  ///simple animation when user tabs button.
  ///-> Very slow response, need to be optimized
  _animationOnTapDown(TapDownDetails details) {
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }
  ///Show Alert Dialog when user finished training
  void _showFinishScreen(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Training abgeschlossen"),
            actions: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).accentColor,
                onPressed: (){

                  final planService = Provider.of<PlanService>(context, listen: false);
                  final timer = Provider.of<ExecutionTimerModel>(context, listen: false);

                  timer.saveTimeToDB(planService, widget.planModel);
                  timer.kill();

                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, NamedRoutes.ROUTE_NAVIGATIONSTACK);
                },
                child: Text(
                  Names.BASIC_ACCEPT,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
