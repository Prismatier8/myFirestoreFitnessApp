import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/breakPauseButton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/cancelExecutionbutton.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/detailPane.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';


class ExecutionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CancelExecutionButton(),
            /*
            Text(
              Names.TITLE_EXECUTION,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),

             */
          ],

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BreakPauseButton(planModel),
      body: Column(
        children: <Widget>[
          DetailPane(planModel),
          SetPane(),
        ],
      ),
    );
  }
}
