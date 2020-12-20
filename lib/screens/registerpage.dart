import 'package:flutter/material.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

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
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      confirmPassword: password2Controller.text.trim(),
                    );
                Navigator.of(context).pop();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
