import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/services/barservice.dart';

class ViewBarPage extends StatelessWidget{

  final BarService service = new BarService();

  static List<Bar> bars = [];

  void loadBars() async{
    bars = await service.getBars();
  }

  ViewBarPage.initialize(){
    loadBars();
  }

  Widget makeWidget(Bar bar){
    return ListTile(
      title: Text(bar.getName()),
      subtitle: Text(bar.getDescription()),
      trailing: IconButton(
        icon: Icon(Icons.keyboard_arrow_right),
        tooltip: 'visit bar',
        onPressed: (){
          //TODO navigate to bar
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bars"),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: bars.length,
              itemBuilder: (context, index) {
                return makeWidget(bars[index]);
              },
          )
      )
    );
  }

}