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
      //resizeToAvoidBottomInset: false,
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

      floatingActionButton: BreakPauseButton(planModel
      ),
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
