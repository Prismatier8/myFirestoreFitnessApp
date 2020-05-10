import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseButton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cancelExecutionbutton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/detailPane.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';
import 'package:myfitnessmotivation/providerModel/executionModel.dart';
import 'package:provider/provider.dart';


class ExecutionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DetailPane(planModel),
            SetPane(planModel),
          ],
        ),
      ),
    );
  }
}
