import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/detailPane.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/setPane.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class ExecutionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          Names.TITLE_EXECUTION,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 45),
        child: SizedBox(
          height: 130,
          width: 130,
          child: FloatingActionButton(
            onPressed: () {
              //TODO: Start next Cycle
            },
            child: Icon(
              Icons.hourglass_empty,
              size: 40,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlueAccent,
            heroTag: Names.HEROTAG_FLOATINGBUTTON,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          DetailPane(),
          SetPane(),
        ],
      ),
    );
  }
}
