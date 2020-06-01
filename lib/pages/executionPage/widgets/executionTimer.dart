import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/executionPage/provider/executionTimerModel.dart';
import 'package:provider/provider.dart';

class ExecutionTimer extends StatefulWidget {
  final PlanModel plan;
  ExecutionTimer(this.plan);
  @override
  _ExecutionTimerState createState() => _ExecutionTimerState();
}

class _ExecutionTimerState extends State<ExecutionTimer> {
  @override
  void initState() {
    final timer = Provider.of<ExecutionTimerModel>(context, listen: false);
    timer.init().then((value){
      setState(() {});
    });
    super.initState();
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
          Consumer<ExecutionTimerModel>(
            builder: (context, timer, _){
              return Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  timer.getTime().toString() + " min",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
