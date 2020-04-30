import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/stringResources/generalStrings.dart';

class StaticTagWidget extends StatelessWidget {
  final String _title;

  StaticTagWidget(this._title);

  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 90,
      child: Card(
        color: getColorByTitle(),
        child: Center(
          child: Text(
            _title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  Color getColorByTitle(){
    switch(_title){
      case Names.TAGS_MONDAY:
        return Colors.lightBlueAccent;
      case Names.TAGS_TUESDAY:
        return Colors.green;
      case Names.TAGS_WEDNESDAY:
        return Colors.orangeAccent;
      case Names.TAGS_THURSDAY:
        return Colors.deepPurpleAccent;
      case Names.TAGS_FRIDAY:
        return Colors.redAccent;
      case Names.TAGS_SATURDAY:
        return Colors.pinkAccent;
      case Names.TAGS_SUNDAY:
        return Colors.indigoAccent;
      default:
        return Colors.grey;
    }
  }
}
