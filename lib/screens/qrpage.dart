import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatelessWidget{

  String _barid;

  QRPage(String barid){
    _barid = barid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: QrImage(
          data: _barid,
          version: QrVersions.auto,
          size: 300,
        ),
      ),
    );
  }

}