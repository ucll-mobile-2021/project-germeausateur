import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:germeau_sateur/services/itemservice.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/screens/confirmorderpage.dart';

class MenuPage extends StatefulWidget {
  String _barid;

  MenuPage(String barid) {
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

  double price = 0;

  void addtotal(item) {
    price += double.parse(item);
  }

  void minustotal(item) {
    price -= double.parse(item);
  }

  List<Item> orderList = [];

  void createOrderList() {
    orderList = [];
    items.forEach((item) {
      if (_counter.containsKey(item.getId()) && _counter[item.getId()] != 0) {
        orderList.add(item);
      }
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
                  minustotal(item.getPrice());
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
                  addtotal(item.getPrice());
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Totaal",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "$price €",
              style: TextStyle(fontSize: 24),
            ),
            RaisedButton(
              onPressed: () {
                createOrderList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmOrderPage(
                          counter: _counter,
                          price: price,
                          items: items,
                          orderList: orderList)),
                );
              },
              child: Text(
                "Bestel",
                style: new TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
