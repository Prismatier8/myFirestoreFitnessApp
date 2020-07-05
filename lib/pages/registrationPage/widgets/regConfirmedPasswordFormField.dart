import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/registrationPage/provider/registrationValidator.dart';
import 'package:provider/provider.dart';

class ConfirmedPasswordFormField extends StatefulWidget {
  final FocusNode focusNode;
  final bool hidePassword;
  ConfirmedPasswordFormField({
    @required this.focusNode,
    @required this.hidePassword});
  @override
  _ConfirmedPasswordFormFieldState createState() =>
      _ConfirmedPasswordFormFieldState();
}

class _ConfirmedPasswordFormFieldState
    extends State<ConfirmedPasswordFormField> {
  @override
  Widget build(BuildContext context) {
    final registrationValidator = Provider.of<RegistrationValidator>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        style: TextStyle(fontFamily: "Raleway"),
        focusNode: widget.focusNode,
        validator: (confirmedPassword){
          if(confirmedPassword != registrationValidator.currentPassword){
            return "Dein Passwort muss übereinstimmen";
          }
          return null;
        },
        obscureText: widget.hidePassword ? true : false,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).accentColor,
          ),
          labelText: "Passwort bestätigen",
        ),
      ),
    );
  }
}
