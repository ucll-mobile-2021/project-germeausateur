import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/screens/qrpage.dart';
import 'package:germeau_sateur/services/barservice.dart';

import 'menupage.dart';

final BarService service = new BarService();

class GenerateQRPage extends StatefulWidget{
  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();

  }
  
class _GenerateQRPageState extends State<GenerateQRPage>{

  Future<List<Bar>> loadBars() async {
    return await service.getBars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Generate QR"),
        ),
        body: Container(
            child: FutureBuilder(
              future: loadBars(),
              builder: (BuildContext context, AsyncSnapshot snapshot){

                if(snapshot.data == null){
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        title: Text(snapshot.data[index].getName()),
                        subtitle: Text(snapshot.data[index].getDescription()),
                        trailing: IconButton(
                          icon: Icon(Icons.keyboard_arrow_right),
                          tooltip: 'visit bar',
                          onPressed: () {
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => QRPage(snapshot.data[index].getId())));
                          },
                        ),
                      );
                    },
                  );
                }
                  
              },
            )
        )
      );
  }
}