import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/order.dart';
import 'package:germeau_sateur/screens/menupage.dart';
import 'package:germeau_sateur/services/barservice.dart';

final BarService service = new BarService();

class ViewOrderPage extends StatefulWidget {
  @override
  _ViewOrderPageState createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  Future<List<Order>> loadOrders() async {
    //return await service.getOrdersFromBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: Container(
            child: FutureBuilder(
          future: loadOrders(),
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
                    title: Text(snapshot.data[index].gettable()),
                    subtitle: Text(snapshot.data[index].getDescription()),
                    trailing: IconButton(
                      icon: Icon(Icons.keyboard_arrow_right),
                      tooltip: 'visit bar',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MenuPage(snapshot.data[index].getId())));
                      },
                    ),
                  );
                },
              );
            }
          },
        )));
  }
}
