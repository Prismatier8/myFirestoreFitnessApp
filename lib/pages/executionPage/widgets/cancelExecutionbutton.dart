import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/providerModel/breakPauseModel.dart';
import 'package:myfitnessmotivation/stringResources/routesStrings.dart';
import 'package:provider/provider.dart';

class CancelExecutionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 20),
        child: GestureDetector(
          onTap: (){
            final breakPause = Provider.of<BreakPauseModel>(context, listen: false);
            breakPause.stop();
            Navigator.pushReplacementNamed(context, NamedRoutes.ROUTE_NAVIGATIONSTACK);
          },
          child: Icon(Icons.clear, size: 40,
          ),
        ),
      ),
    );
  }
}
