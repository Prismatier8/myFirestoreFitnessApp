import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class CancelExecutionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final execution = Provider.of<ExecutionModel>(context, listen: false);
    final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: GestureDetector(
          onTap: (){
            execution.clear();
            breakPause.stop();
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
