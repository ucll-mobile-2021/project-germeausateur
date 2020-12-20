import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailOrderPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Order order;
  String barId;
  //List<Item> itemsInOrder = order.getItems();

  DetailOrderPage({this.order, this.barId});
  Map<Item, int> count = Map();
  List<Item> DistinctItems = [];

  void toCount() {
    List<Item> orders = order.getItems();
    orders.forEach((item) {
      if (count.containsKey(item)) {
        count.update(item, (i) => i + 1);
      } else {
        count.putIfAbsent(item, () => 1);
        DistinctItems.add(item);
      }
    });
  }

  Widget makeWidget(Item item) {
    return ListTile(
      title: Text(item.getName()),
      subtitle: Text(
        item.getSize() + "ml",
        style: TextStyle(fontSize: 10),
      ),
      trailing: Text(""),
    );
    //trailing: Text(counter[item.getId()].toString()),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details              " + order.getTable()),
      ),
      body: Container(
          child: ListView.builder(
        itemCount: order.getItems().length,
        itemBuilder: (context, index) {
          return makeWidget(order.getItems()[index]);
        },
      )),
      /*  bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          onPressed: () {
            context.read<BarService>().setOrderToComplete(barId, order.getId());
          },
          child: Text(
            "Confirm Order",
          ),
        ),
      ),
    */
    );
  }
}
