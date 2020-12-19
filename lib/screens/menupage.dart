import 'package:flutter/material.dart';
import 'package:germeau_sateur/services/barservice.dart';
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

  String _barId;

  _MenuPageState.initialize(String barid) {
    _barId = barid;
    loadCounter();
    print(
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    print(items);
  }

  final BarService service = new BarService();

  static List<Item> items = [];

  Map<String, int> _counter = Map();

  Future loadItems(String barid) async {
    var out = await service.getMenuFromBar(barid);
    items = out;
    return out;
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
          if (!_counter.containsKey(item.getId()))
            Text("0")
          else
            Text(_counter[item.getId()].toString()),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              setState(() {
                _counter.putIfAbsent(item.getId(), () => 0);
                if (_counter[item.getId()] != 25) {
                  _counter.update(item.getId(), (i) => i + 1);
                  addtotal(item.getPrice());
                }
              });
            },
          ),
        ]));
  }

  void quickfix() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Container(
          child: FutureBuilder(
        future: loadItems(_barId),
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
                return makeWidget(snapshot.data[index]);
              },
            );
          }
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
