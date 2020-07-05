
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginButton.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginEmailFormField.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginPasswordFormField.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/navigateRegistrationText.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double safeArea = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: <Widget>[
          Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 25, top: 100),
                  child: Column(
                    children: <Widget>[
                      RegistrationText(),
                      LoginEmailFormField(focusNode: _focusNode,),
                      LoginPasswordFormField(focusNode: _focusNode,),
                      Container(
                        height: (MediaQuery.of(context).size.height - safeArea) * 0.08,),
                      LoginButton(_formKey),

                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
