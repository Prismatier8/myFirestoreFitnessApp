import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/registrationPage/provider/registrationValidator.dart';
import 'package:provider/provider.dart';

class EmailFormField extends StatefulWidget {
  final FocusNode focusNodeUser;
  final FocusNode focusNodeEmail;
  EmailFormField({@required this.focusNodeEmail, @required this.focusNodeUser});
  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    final registrationValidator =
    Provider.of<RegistrationValidator>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        style: TextStyle(fontFamily: "Raleway"),
        focusNode: widget.focusNodeUser,
        keyboardType: TextInputType.emailAddress,
        onChanged: (emailValue) {
          registrationValidator.setEmail(emailValue);
        },
        onFieldSubmitted: (value){
          if(value.isNotEmpty){
            FocusScope.of(context).requestFocus(widget.focusNodeEmail);
          }
        },
        validator: (emailValue) {
          if (emailValue.isEmpty) {
            return "Es fehlt noch deine E-Mail";
          }
          if (registrationValidator.isEmailInUse) {
            return "Deine E-Mail wird bereits genutzt";
          }

          if (registrationValidator.isInvalidEmail)
            return "Emailadresse nicht korrekt";
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            color: Theme.of(context).accentColor,
          ),
          labelText: "E-Mail",
        ),
      ),
    );
  }
}
