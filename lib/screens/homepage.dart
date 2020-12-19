import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:germeau_sateur/screens/viewbarsPage.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:germeau_sateur/screens/createbarpage.dart';

import 'package:provider/provider.dart';

import 'menupage.dart';

class HomePage extends StatelessWidget {

  _scan(BuildContext context) async{
    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", false, ScanMode.QR)
      .then((value) => {

          Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MenuPage(value)))

      });
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateBarPage()),
                );
              },
              child: Text('Create new bar'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewBarPage()),
                );
              },
              child: Text('Bars'),
            ),
            RaisedButton(
              onPressed: () {
                _scan(context);
              },
              child: Text('Scan QR'),
            ),
          ],
        ),
      ),
    );
  }
}
