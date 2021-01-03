import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/screens/menupage.dart';
import 'package:germeau_sateur/screens/detailorderpage.dart';

import 'package:germeau_sateur/services/barservice.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

final BarService service = new BarService();
final FirebaseAuth auth = FirebaseAuth.instance;

class ViewOrderPage extends StatefulWidget {
  String _barid;

  ViewOrderPage(String barid) {
    _barid = barid;
  }

  @override
  _ViewOrderPageState createState() => _ViewOrderPageState.initialize(_barid);
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  _ViewOrderPageState() : super();

  String _barId;

  _ViewOrderPageState.initialize(String barid) {
    _barId = barid;
  }
  static List<Order> orders = [];

  Future loadOrders(String barid) async {
    var out = await service.getOrdersFromBar2(barid);
    orders = out;
    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: Container(
            child: FutureBuilder(
          future: loadOrders(_barId),
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
                      title: Text(snapshot.data[index].getTable()),
                      //subtitle: Text(snapshot.data[index].getId()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!snapshot.data[index].getCompleted())
                            IconButton(
                              icon: Icon(Icons.check_circle_outline,
                                  color: Colors.redAccent),
                              tooltip: 'Check',
                              onPressed: () {
                                setState(() {
                                  //color = Colors.greenAccent;
                                });

                                context.read<BarService>().setOrderToComplete(
                                    _barId, snapshot.data[index].getId());
                              },
                            )
                          else
                            IconButton(
                              icon: Icon(Icons.check_circle,
                                  color: Colors.greenAccent),
                              tooltip: 'Check',
                              onPressed: () {},
                            ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            tooltip: 'Details',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailOrderPage(
                                        order: snapshot.data[index],
                                        barId: _barId)),
                              );
                            },
                          ),
                        ],
                      ));
                },
              );
            }
          },
        )));
  }
}
