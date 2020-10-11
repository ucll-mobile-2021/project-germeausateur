import 'package:flutter/material.dart';
import 'package:germeau_sateur/screens/OrderDetails.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Incoming orders"),
      ),
      body: new ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text(
              '#0705650',
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            leading: Text(
              '1',
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
            trailing: new IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetails()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
