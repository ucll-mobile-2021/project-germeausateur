import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:germeau_sateur/models/bar.dart';

class BarService {

  final CollectionReference colRef = FirebaseFirestore.instance.collection('bars');

  Future<void> createBar(Bar bar) async{
    try{
        await colRef.add(bar.toMap());
    }catch (e){
        return e.toString();
    }
  }

  Future<List<Bar>>getBars() async{
    try{
      List<Bar> bars = [];
      colRef.get().then((value) {
        
        for (DocumentSnapshot bar in value.docs){
          bars.add(Bar.fromMap(bar.data(), bar.id));
        }
        
      });
      return bars;
    }catch (e){
      return e.message;
    }
  }

}