import 'package:flutter/material.dart';

class SetPane extends StatefulWidget {
  @override
  _SetPaneState createState() => _SetPaneState();
}

class _SetPaneState extends State<SetPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: _getBodySizeHeight(),
      child: Card(),
    );
  }
  double _getBodySizeHeight(){
    final maxHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return (maxHeight - statusBarHeight) / 2.5;
  }
}
