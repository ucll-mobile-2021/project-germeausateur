import 'package:flutter/material.dart';
import 'package:germeau_sateur/authentication_service.dart';
//import 'package:germeau_sateur/screens/createbarpage.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text('Sign out'),
            ),
            RaisedButton(
              onPressed: () {
                // Navigator.push(
                //context,
                //  MaterialPageRoute(builder: (context) => CreateBarPage()),
                // );
              },
              child: Text('Creae new store'),
            )
          ],
        ),
      ),
    );
  }
}
