
import 'package:flutter/material.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginButton.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginEmailFormField.dart';
import 'package:myfitnessmotivation/pages/loginPage/widgets/loginPasswordFormField.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text("Anmelden",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 25, top: 100),
                child: Column(
                  children: <Widget>[
                    LoginEmailFormField(),
                    LoginPasswordFormField(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
                  0.05,
            ),
            LoginButton(_formKey),
          ],
        ),
      ),
    );
  }
}
