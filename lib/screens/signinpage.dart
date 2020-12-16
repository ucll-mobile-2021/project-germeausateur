import 'package:flutter/material.dart';
import 'package:germeau_sateur/authentication_service.dart';
import 'package:germeau_sateur/screens/registerpage.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          RaisedButton(
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
            },
            child: Text('Sing in'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text('Register'),
          )
        ],
      ),
    );
  }

}