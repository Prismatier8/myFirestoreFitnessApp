import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/pages/preperationPage/widgets/breakPauseDialog.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:provider/provider.dart';

class BreakPause extends StatefulWidget {
  final PlanModel planModel;
  BreakPause(this.planModel);
  @override
  _BreakPauseState createState() => _BreakPauseState();
}

class _BreakPauseState extends State<BreakPause> {
  PlanModel currentPlan;

  @override
  Widget build(BuildContext context) {
   final planService = Provider.of<PlanService>(context, listen: false);
    return GestureDetector(
      onTap: (){
        _showBreakPauseDialog(context, currentPlan);
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.hourglass_empty, color: Theme.of(context).accentColor,
              size: 40,
            ),
            FutureBuilder(
              future: planService.getPlan(widget.planModel.title),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  final planModel = PlanModel.fromMap(snapshot.data.data);
                  currentPlan = planModel;
                  return Text(

                    planModel.breakPause.toString() + " s",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  );
                } else {
                  return Text(

                    widget.planModel.title.toString() + " s",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  );
                }
              },
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
        }).then((_){
          setState(() {

          });
    });
  }
}
