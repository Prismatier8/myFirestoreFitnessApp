import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/detailPane.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';


class ExecutionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DetailPane(
                planModel, _getTopHalf(context)),
            SetPane(planModel, _getTopHalf(context)),
          ],
        ),
      ),
    );
  }
  ///DetailPane and SetPane should both have a specific height. This method
  ///calculates the height of the top half (in this case DetailPane). This value is
  ///returned to SetPane (bottom half) so that the setPane can calculate further with the
  ///height of the detailPane
  double _getTopHalf(BuildContext context) {
    final heightFactor = 2.5;
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return (maxHeight - statusBarHeight) / heightFactor;
  }
}
