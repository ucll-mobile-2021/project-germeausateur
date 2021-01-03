import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

final BarService service = new BarService();
final FirebaseAuth auth = FirebaseAuth.instance;

class DetailOrderPage extends StatefulWidget {
  String _orderid;
  String _barid;
  //List<Item> itemsInOrder = order.getItems();

  DetailOrderPage(String orderid, String barid) {
    _orderid = orderid;
    _barid = barid;
  }

  @override
  _DetailOrderPageState createState() =>
      _DetailOrderPageState.initialize(_orderid, _barid);
}
// DetailOrderPage({this.order, this.barId});

class _DetailOrderPageState extends State<DetailOrderPage> {
  _DetailOrderPageState() : super();

  String _orderId;
  String _barId;

  _DetailOrderPageState.initialize(String orderid, String barid) {
    _orderId = orderid;
    _barId = barid;
  }

  static List<Item> order = [];

  Future loadItemsFromOrder(String orderid, String barid) async {
    var out = await service.getItemsFromOrder(orderid, barid);
    order = out;
    return out;
  }

  Map<Item, int> count = Map();
  List<Item> DistinctItems = [];

  void toCount() {
    order.forEach((item) {
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
          title: Text("Order Details"),
        ),
        body: Container(
            child: FutureBuilder(
          future: loadItemsFromOrder(_orderId, _barId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: order.length,
                itemBuilder: (context, index) {
                  print(
                      "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                  print(order.length);
                  return makeWidget(order[index]);
                },
              );
            }
          },
        )));
  }
}
