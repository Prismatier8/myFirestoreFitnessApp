import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';

class PlanDuration extends StatefulWidget {
  final PlanModel plan;
  PlanDuration(this.plan);
  @override
  _PlanDurationState createState() => _PlanDurationState();
}

class _PlanDurationState extends State<PlanDuration> {
  @override
  Widget build(BuildContext context) {
    return widget.plan.planDuration == 0
        ? Container()
        : Text(
      widget.plan.planDuration.toString() + " min",
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
      ),
    );
  }
}
