import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/globalWidgets/myBottomNavigationBar.dart';
import 'package:myfitnessmotivation/globalWidgets/navigationIndexStack.dart';
import 'package:myfitnessmotivation/providerModel/navigationModel.dart';
import 'package:myfitnessmotivation/providerModel/tagSelectionModel.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TagSelectionModel(),
        ),
      ],
      child: MyApp(
        
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final Firestore firestoreDB = Firestore.instance;

    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(),
        body: NavigationIndexStack(),
      ),
    );
  }
  /*
  addCollectionToDataBase(Firestore db) async{
    await db.collection("plans").document().collection("Exercises").add({
      'title' : 'myTitle',
      'breakPause' : '20'
    });
  }
  */
}
