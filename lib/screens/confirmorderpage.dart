import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmOrderPage extends StatelessWidget {
  final TextEditingController tableController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Item> items = [];

  Map<String, int> counter = Map();
  double price;
  String barid;
  List<Item> orderList = [];
  List<Item> orderDBList = [];

  ConfirmOrderPage(
      {this.counter, this.price, this.items, this.orderList, this.barid});

  void ConvertToOrder() {
    counter.forEach((element, value) {
      for (int i = value; i != 0; i--) {
        orderList.forEach((item) {
          if (item.getId() == element) {
            orderDBList.add(item);
          }
        });
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
      subtitle: Text(
        item.getSize() + "ml",
        style: TextStyle(fontSize: 10),
      ),
      trailing: Text(counter[item.getId()].toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text("Fill in table number"),
                content: TextField(
                  controller: tableController,
                  decoration: InputDecoration(
                    labelText: 'table number',
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      Order order = new Order(
                        orderDBList,
                        false,
                        tableController.text.trim(),
                      );

                      context.read<BarService>().addOrderToBar(barid, order);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Total",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "$price €",
              style: TextStyle(fontSize: 24),
            ),
            RaisedButton(
              onPressed: () {
                ConvertToOrder();
                _showMaterialDialog();
              },
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
