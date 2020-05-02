import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/breakPauseDialog.dart';

class BreakPause extends StatefulWidget {
  final PlanModel planModel;
  BreakPause(this.planModel);
  @override
  _BreakPauseState createState() => _BreakPauseState();
}

class _BreakPauseState extends State<BreakPause> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _showBreakPauseDialog(context, widget.planModel);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.hourglass_empty, color: Theme.of(context).accentColor,
              size: 40,
            ),
            Text(
              widget.planModel.breakPause.toString() + " s",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showBreakPauseDialog(context, planModel) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return BreakPauseDialog(planModel);
        });
  }
}
