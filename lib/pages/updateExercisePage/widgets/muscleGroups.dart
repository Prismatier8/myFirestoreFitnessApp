import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class MuscleGroups extends StatefulWidget {
  @override
  _MuscleGroupsState createState() => _MuscleGroupsState();
}

class _MuscleGroupsState extends State<MuscleGroups> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            //TODO: MuscleGroupSelectionDialog
          },
          child: Text(
            Names.BASIC_MUSCLEGROUPS,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        //TODO: Streambuilder for Musclegroupselections (shows musclegroups as text)
      ],
    );
  }
}
