class Item {
  String _name;
  String _price;
  String _size;
  String _itemid;

  Item(this._name, this._price, this._size);

  Item.withid(this._name, this._price, this._size, this._itemid);

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'price': _price,
      'size': _size,
    };
  }

  Item.fromData(Map<String, dynamic> data)
      : _name = data['name'],
        _price = data['price'],
        _size = data['size'];

  static Item fromMap(Map<String, dynamic> map, String id) {
    if (map == null) return null;

    return Item.withid(map['name'], map['price'], map['size'], id);
  }

  String getName() {
    return this._name;
  }

  String getPrice() {
    return _price;
  }

  String getSize() {
    return _size;
  }

  String getId() {
    return _itemid;
  }
}
