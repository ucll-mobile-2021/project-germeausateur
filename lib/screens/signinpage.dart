import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            validator: EmailValidator.validate,
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: InputBorder.none,
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
                MaterialPageRoute(builder: (context) => CreateItemPage()),
              );
            },
            child: Text('Test'),
          )
        ],
      ),
    );
  }
}
