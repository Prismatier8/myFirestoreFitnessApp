import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/provider/executionTimerModel.dart';
import 'file:///C:/Users/R4pture/AndroidStudioProjects/myFirestoreFitnessApp/lib/pages/executionPage/provider/breakPauseModel.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class CancelExecutionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
    final timer = Provider.of<ExecutionTimerModel>(context, listen: false);

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: GestureDetector(
          onTap: (){
            breakPause.stop();
            timer.kill();
            Navigator.pushReplacementNamed(context, NamedRoutes.ROUTE_NAVIGATIONSTACK);
          },
          child: Icon(
            Icons.clear,
            size: 50,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
