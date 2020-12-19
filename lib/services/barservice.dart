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

  Future<List<Order>> getOrdersFromBar(String barid) async {
    try {
      List<Order> order = [];

      await colRef.doc(barid).collection("order").get().then((value) {
        for (DocumentSnapshot order in value.docs) {
          //order.add(Item.fromMap(order.data(), order.id));
        }
      });
      return order;
    } catch (e) {
      return e.message;
    }
  }
}
