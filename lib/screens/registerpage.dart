import 'package:flutter/material.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                autovalidate: true,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.grey[800],
                  filled: true,
                ),
                autocorrect: false,
                enableSuggestions: false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: Colors.grey[800],
                  filled: true,
                ),
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
              ),
            ),
            TextField(
              controller: password2Controller,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                fillColor: Colors.grey[800],
                filled: true,
              ),
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
            ),
            RaisedButton(
              onPressed: () {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    password2Controller.text.isNotEmpty &&
                    passwordController.text == password2Controller.text &&
                    isEmail(emailController.text) &&
                    passwordController.text.length > 5) {
                  context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: password2Controller.text.trim(),
                      );
                  Navigator.of(context).pop();
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid input'),
                          content: Text('Something went wrong'),
                          actions: [
                            FlatButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
