import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/trainingPage/Widgets/staticTagWidget.dart';

class PlanTags extends StatelessWidget {
  final plan;
  PlanTags({@required this.plan});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: plan.tags.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 5, left: 0),
              child: StaticTagWidget(plan.tags[index]),
            );
          }),
    );
  }
}
