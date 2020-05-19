import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/planTags.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/deletePlanDialog.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/staticTagWidget.dart';
import 'package:myfitnessmotivation/services/planService.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class Plan extends StatefulWidget {
  final PlanModel plan;

  Plan({@required this.plan});

  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 6,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, NamedRoutes.ROUTE_PREPERATIONPAGE, arguments: widget.plan);
                      },
                      onLongPress: (){
                        _showDeletePlanDialog(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PlanTags(plan: widget.plan,),
                          Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 20),
                              child: Text(
                                widget.plan.title,
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ),
                  ),
                Align(
                  alignment: widget.plan.exerciseRef.isNotEmpty
                      ? Alignment.centerRight
                      : Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, NamedRoutes.ROUTE_CHOOSEEXERCISEPAGE, arguments: widget.plan);
                      },
                      child: _displayPlanDuration(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _displayPlanDuration() {
    if (widget.plan.exerciseRef.isNotEmpty) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.update,
              color: Colors.white,
              size: 30,
            ),
            Text(
              "120 Min",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            Text(
              "Keine Übungen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }
  }
  String _calculateMinimumPlanExecution(){
    //TODO: Calculate Minimum Plan Execution with queries and FutureBuilder to show result???
  }
  void _showDeletePlanDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DeletePlanDialog(widget.plan);
        });
  }
}
