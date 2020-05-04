import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/executionPage/widgets/executionTimer.dart';

class DetailPane extends StatefulWidget {
  @override
  _DetailPaneState createState() => _DetailPaneState();
}

class _DetailPaneState extends State<DetailPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      width: MediaQuery.of(context).size.width,
      height: _getBodySizeHeight(),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ExecutionTimer(),
            ],
          ),
        ],
      ),
    );
  }
  double _getBodySizeHeight(){
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return (maxHeight - statusBarHeight) / 3.2;
  }
}
