import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/models/order.dart';

class BarService {
  final CollectionReference colRef =
      FirebaseFirestore.instance.collection('bars');

  Future<void> createBar(Bar bar, String uid) async {
    try {
      if (!await userHasBar(uid)) {
        await colRef.add(bar.toMap());
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getBarFromUser(String uid) async {
    String barid = "";
    await colRef.where("userid", isEqualTo: uid).get().then((value) {
      for (DocumentSnapshot snapshot in value.docs) {
        barid = snapshot.id;
      }
    });
    return barid;
  }

  Future<void> createItem(Item item, String uid) async {
    try {
      await colRef
          .doc(await getBarFromUser(uid))
          .collection("menu")
          .add(item.toMap());
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> userHasBar(String uid) async {
    bool out = false;
    await colRef.get().then((value) => {
          for (DocumentSnapshot bar in value.docs)
            {
              if (bar['userid'] == uid) {out = true}
            }
        });
    return out;
  }

  Future<List<Bar>> getBars() async {
    try {
      List<Bar> bars = [];
      await colRef.get().then((value) {
        for (DocumentSnapshot bar in value.docs) {
          bars.add(Bar.fromMap(bar.data(), bar.id));
        }
      });
      return bars;
    } catch (e) {
      return e.message;
    }
  }

  Future<List<Item>> getMenuFromBar(String barid) async {
    try {
      List<Item> menu = [];

      await colRef.doc(barid).collection("menu").get().then((value) {
        for (DocumentSnapshot item in value.docs) {
          menu.add(Item.fromMap(item.data(), item.id));
        }
      });
      return menu;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> barExists(String barid) async {
    bool out = false;
    await colRef.get().then((value) => {
          for (DocumentSnapshot bar in value.docs)
            {
              if (bar.id == barid) {out = true}
            }
        });
    return out;
  }

  Future<void> addOrderToBar(String barid, Order order) async {
    try {
      await colRef
          .doc(barid)
          .collection("orders")
          .add(order.toMap())
          .then((value) => {
                order.getItems().forEach((element) {
                  colRef
                      .doc(barid)
                      .collection("orders")
                      .doc(value.id)
                      .collection("items")
                      .add({'itemid': element.getId()});
                })
              });
    } catch (e) {
      return e.message;
    }
  }

  Future<void> setOrderToComplete(String barid, String orderid) async {
    await colRef
        .doc(barid)
        .collection("orders")
        .doc(orderid)
        .update({'completed': true});
  }

  Future<List<Order>> getOrdersFromBar(String barid) async {
    List<Order> orders = [];

    //get alle orders
    await colRef.doc(barid).collection("orders").get().then((value) async {
      for (DocumentSnapshot order in value.docs) {
        List<Item> orderItems = [];
        //get alle itemsid's van die order
        await colRef
            .doc(barid)
            .collection("orders")
            .doc(order.id)
            .collection('items')
            .get()
            .then((value) async {
          for (DocumentSnapshot snapshot in value.docs) {
            String iid = snapshot.data()['itemid'];

            //get alle items van een menu
            await getMenuFromBar(barid).then((value) {
              //itemid van order linken met item van menu
              for (Item item in value) {
                if (iid == item.getId()) {
                  orderItems.add(item);
                }
              }
            });
          }
        });

        Order _order = new Order.fromData(order.data(), order.id);
        _order.setItems(orderItems);
        orders.add(_order);
      }
    });
    return orders;
  }
}
