import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/globalWidgets/myBottomNavigationBar.dart';
import 'package:myfitnessmotivation/globalWidgets/navigationIndexStack.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: NavigationIndexStack(),
    );
  }
}
