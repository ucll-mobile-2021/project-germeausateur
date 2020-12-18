import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:germeau_sateur/services/itemservice.dart';
import 'package:germeau_sateur/models/Item.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class MenuPage extends StatefulWidget {

  String _barid;

  MenuPage(String barid){
    _barid = barid;
  }

  @override
  _MenuPageState createState() => _MenuPageState.initialize(_barid);
}

class _MenuPageState extends State<MenuPage> {
  _MenuPageState() : super();

  _MenuPageState.initialize(String barid) {
    loadItems(barid);
    loadCounter();
  }

  final BarService service = new BarService();

  static List<Item> items = [];

  Map<String, int> _counter = Map();

  void loadItems(String barid) async {
    items = await service.getMenuFromBar(barid);
    
  }

  void loadCounter() {
    items.forEach((item) {
      _counter[item.getId()] = 0;
    });
  }

  Widget makeWidget(Item item) {
    return ListTile(
        leading: Text("Image"),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Text(item.getName()), Text(item.getPrice() + "€")],
        ),
        subtitle: Text(item.getSize() + "ml"),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              setState(() {
                if (_counter[item.getId()] != 0) {
                  _counter.update(item.getId(), (i) => i - 1);
                }
              });
            },
          ),
          Text(_counter[item.getId()].toString()),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                if (_counter[item.getId()] != 25) {
                  _counter.update(item.getId(), (i) => i + 1);
                }
              });
            },
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return makeWidget(items[index]);
        },
      )),
    );
  }
}
