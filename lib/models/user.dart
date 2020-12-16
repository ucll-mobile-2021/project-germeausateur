class User {
    String _name;
    int _id;
    String _email;

    User(this._name, this._id, this._email);

    String getName(){
      return _name;
    }

    int getId(){
      return _id;
    }
    String getEmail(){
      return _email;
    }

    void setName(String name){
      _name = name;
    }
    void setId(int id){
      _id = id;
    }
    void setEmail(String email){
      _email = email;
    }
}