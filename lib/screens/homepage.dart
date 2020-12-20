import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:germeau_sateur/models/Item.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/screens/generateqrpage.dart';
import 'package:germeau_sateur/screens/mybarpage.dart';
import 'package:germeau_sateur/screens/viewbarsPage.dart';
import 'package:germeau_sateur/screens/createitempage.dart';
import 'package:germeau_sateur/services/authentication_service.dart';
import 'package:germeau_sateur/screens/createbarpage.dart';
import 'package:germeau_sateur/screens/ordersoverviewpage.dart';

import 'package:germeau_sateur/services/barservice.dart';

import 'package:provider/provider.dart';

import 'menupage.dart';

class HomePage extends StatelessWidget {
  BarService service = new BarService();

  _scan(BuildContext context) async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancel", false, ScanMode.QR)
        .then((value) async => {
              if (value != null && await service.barExists(value))
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuPage(value)))
                }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyBarPage()),
                );
              },
              child: Text('My Bar'),
            ),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
