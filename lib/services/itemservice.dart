import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:germeau_sateur/models/item.dart';

class ItemService {
  final CollectionReference colRef =
      FirebaseFirestore.instance.collection('items');

  Future<void> createItem(Item item) async {
    try {
      await colRef.add(item.toMap());
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Item>> getItems() async {
    try {
      List<Item> items = [];
      colRef.get().then((value) {
        for (DocumentSnapshot item in value.docs) {
          items.add(Item.fromMap(item.data(), item.id));
        }
      });
      print(
          "DIKEFUCKERHIERBENIKDIKKEONZONZELAARXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
      print(items.length);
      return items;
    } catch (e) {
      return e.message;
    }
  }
}
