class Bar{
    String _name;
    String _description;
    String _userid;
    String _barid;

    
    Bar(this._userid, this._name, this._description);

    Bar.withid(this._userid, this._name, this._description, this._barid);

    Map<String, dynamic> toMap(){
      return {
        'name': _name,
        'description': _description,
        'userid': _userid,
      };
    }

  Bar.fromData(Map<String, dynamic> data , String barid)
    : _userid = data['userid'],
      _name = data['name'],
      _description = data['description'],
      _barid = barid;

  static Bar fromMap(Map<String, dynamic> map, String id){
    if(map == null) return null;

    return Bar.withid(map['userid'], map['name'],map['description'], id);
  }

  String getName(){
    return this._name;
  }
  String getId(){
    return _barid;
  }
  String getDescription(){
    return _description;
  }

}