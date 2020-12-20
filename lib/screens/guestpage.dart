import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:germeau_sateur/screens/menupage.dart';
import 'package:germeau_sateur/screens/viewbarsPage.dart';

class GuestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
            RaisedButton.icon(
              onPressed: () {
                _scan(context);
              },
              label: Text('Scan QR'),
              icon: FaIcon(FontAwesomeIcons.qrcode),
              
            ),
          
            
          
          ],
        ),
      ),
    );
  }

  _scan(BuildContext context) async{
    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", false, ScanMode.QR)
      .then((value)async => {
          if(value != null && await service.barExists(value)){
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MenuPage(value)))
          }
      });
  }

}