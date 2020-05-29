import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/planTags.dart';
import 'package:myfitnessmotivation/globalWidgets/titleDisplay.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/deletePlanDialog.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/planDuration.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';


class Plan extends StatefulWidget {
  final PlanModel plan;

  Plan({@required this.plan});

  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  Widget build(BuildContext context) {
    final widthFactor = 0.95;
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, NamedRoutes.ROUTE_PREPERATIONPAGE,
                          arguments: widget.plan);
                    },
                    onLongPress: () {
                      _showDeletePlanDialog(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PlanTags(
                          plan: widget.plan,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 6, bottom: 20),
                            child: TitleDisplay(
                              containerWidth: (MediaQuery.of(context).size.width * widthFactor) - 90,
                              containerHeight: 20,
                              title: widget.plan.title,
                              fontSize: 18,
                            ),
                        ),
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
                        Navigator.pushNamed(
                            context, NamedRoutes.ROUTE_CHOOSEEXERCISEPAGE,
                            arguments: widget.plan);
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
          widget.plan.planDuration != 0
              ? Icon(
                  Icons.update,
                  color: Colors.white,
                  size: 30,
                )
              : Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                ),
          PlanDuration(widget.plan),
        ],
      ),
    );
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
