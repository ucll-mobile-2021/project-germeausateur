import 'item.dart';

class Kaart {
  int _id;
  List<Item> _items = new List();

  List<Item> getKaart() {
    return _items;
  }

  void addItem(Item item) {
    _items.add(item);
  }

  Item getItem(int i) {
    return _items[i];
  }
}
