import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/screens/menupage.dart';
import 'package:germeau_sateur/screens/ordersoverviewpage.dart';

import 'package:germeau_sateur/services/barservice.dart';

final BarService service = new BarService();

class ViewBarPage extends StatefulWidget {
  @override
  _ViewBarPageState createState() => _ViewBarPageState();
}

class _ViewBarPageState extends State<ViewBarPage> {
  Future<List<Bar>> loadBars() async {
    return await service.getBars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bars"),
        ),
        body: Container(
            child: FutureBuilder(
          future: loadBars(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].getName()),
                    subtitle: Text(snapshot.data[index].getDescription()),
                    trailing: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      tooltip: 'visit bar',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewOrderPage(
                                    snapshot.data[index].getId())));
                      },
                    ),
                  );
                },
              );
            }
          },
        )));
  }
}
