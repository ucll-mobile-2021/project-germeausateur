import 'package:flutter/material.dart';
import 'package:germeau_sateur/screens/guestpage.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:germeau_sateur/screens/registerpage.dart';
import 'package:germeau_sateur/screens/menupage.dart';
import 'package:germeau_sateur/screens/createitempage.dart';

import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              validator: EmailValidator.validate,
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                fillColor: Colors.grey[800],
                filled: true,
              ),
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Password',
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
                  passwordController.text.isNotEmpty) {
                context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid input'),
                        content: Text('Email and password cannot be empty'),
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
            child: Text('Sign in'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text('Register'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuestPage()),
              );
            },
            child: Text('Continue as Guest'),
          ),
        ],
      ),
    ));
  }
}
