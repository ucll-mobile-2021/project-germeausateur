import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _n = 0;
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Text("Image"),
              title: Text("Cola"),
              isThreeLine: true,
              subtitle: Text("33cl"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: (minus),
                  ),
                  Text('$_n'),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: (add),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
