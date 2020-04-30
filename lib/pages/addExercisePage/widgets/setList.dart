import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/services/exerciseService.dart';
import 'package:provider/provider.dart';

class SetList extends StatefulWidget {
  @override
  _SetListState createState() => _SetListState();
}

class _SetListState extends State<SetList> {
  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context);
    return Card(
      //child: ,
    );
  }
}
