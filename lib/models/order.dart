import 'package:germeau_sateur/models/item.dart';

class Order {
  List _items;
  bool _completed;
  String _table;
  String _orderid;

  Order(this._items, this._completed, this._table);

  Order.withid(this._items, this._completed, this._table, this._orderid);

  Map<String, dynamic> toMap() {
    return {
      'completed': _completed,
      'table': _table,
    };
  }

  Order.fromData(Map<String, dynamic> data, String id)
      : _orderid = id,
        _completed = data['completed'],
        _table = data['table'];

  static Order fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;

    return Order.withid(map['items'], map['completed'], map['table'], id);
  }

  void setItems(List<Item> items) {
    _items = items;
  }

  List getItems() {
    return _items;
  }

  bool getCompleted() {
    return _completed;
  }

  String getId() {
    return _orderid;
  }

  String getTable() {
    return _table;
  }
}
