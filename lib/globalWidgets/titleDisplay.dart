import 'package:flutter/cupertino.dart';
class TitleDisplay extends StatelessWidget {
  final String title;
  final double containerHeight;
  final double containerWidth;
  final double fontSize;

  TitleDisplay({
    @required this.title,
    this.fontSize,
    @required this.containerWidth,
    @required this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(title,
          style: TextStyle(
            fontSize: fontSize == null ? 20 : fontSize),
          ),
        ),
      ),
    );
  }
}
