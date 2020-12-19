import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/services/itemservice.dart';

class ConfirmOrderPage extends StatelessWidget {
  List<Item> items = [];

  Map<String, int> counter = Map();
  double price;

  List<Item> orderList = [];

  ConfirmOrderPage({this.counter, this.price, this.items, this.orderList});

  Widget makeWidget(Item item) {
    return ListTile(
      leading: Text("Image"),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Text(item.getName()), Text(item.getPrice() + "€")],
      ),
      subtitle: Text(item.getSize() + "ml"),
      trailing: Text(counter[item.getId()].toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overview"),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          return makeWidget(orderList[index]);
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
              onPressed: () {},
              child: Text(
                "Confirm",
                style: new TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
