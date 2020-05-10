import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/dataModel/planModel.dart';
import 'package:myfitnessmotivation/globalWidgets/planTags.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/staticTagWidget.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';

class PlanWithStats extends StatelessWidget {
  final PlanModel plan;
  PlanWithStats({@required this.plan});

  @override
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
                  elevation: 2,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, NamedRoutes.ROUTE_STAT_MULTIEXERCISESPAGE, arguments: plan);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PlanTags(
                            plan: plan
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 20),
                            child: Text(
                              plan.title,
                              style: TextStyle(fontSize: 18),
                            )
                        ),
                      ],
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
}
