import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/screens/createbarpage.dart';
import 'package:germeau_sateur/screens/createitempage.dart';
import 'package:germeau_sateur/screens/qrpage.dart';
import 'package:germeau_sateur/services/barservice.dart';

class MyBarPage extends StatelessWidget{

  final BarService service = new BarService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Bar> loadBar()async{
    return await service.getBarObjFromUser(auth.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bar'),
      ),
      body: Center(
        child: Container(
        child: FutureBuilder(
          future: loadBar(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Column(
                children: [
                  Text('You have no bar...'),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateBarPage()),
                    );
                  },
                    child: Text('Create new bar'),
                  ),
                ],
              );
            }else{
              return Column(
                children: [
                  Text(snapshot.data.getName(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(snapshot.data.getDescription()),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => QRPage(snapshot.data.getId())));
                  },
                    child: Text('Generate QR'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateItemPage()),
                    );
                  },
                    child: Text('Add item to Menu'),
                  ),
                ],
              );
            }
          },
        ),
      ),
      )
    );
  }

}