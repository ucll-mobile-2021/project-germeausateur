class Order {
  List _items;
  bool _completed;
  String _tafelnr;
  String _orderid;

  Order(this._items, this._completed, this._tafelnr);

  Order.withid(this._items, this._completed, this._tafelnr, this._orderid);

  Map<String, dynamic> toMap() {
    return {
      'items': _items,
      'completed': _completed,
      'tafelnr': _tafelnr,
    };
  }

  Order.fromData(Map<String, dynamic> data)
      : _items = data['items'],
        _completed = data['completed'],
        _tafelnr = data['tafelnr'];

  static Order fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;

    return Order.withid(map['items'], map['completed'], map['tafelnr'], id);
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

  String getTafelNr() {
    return _tafelnr;
  }
}
