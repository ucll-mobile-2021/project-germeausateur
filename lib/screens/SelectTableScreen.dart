import 'package:flutter/material.dart';

class Klant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tafel vermelding"),
      ),
      body: new Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              new TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Vul hier uw tafelnummer in'),
                style: new TextStyle(
                    fontSize: 20.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto"),
              ),
              RaisedButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Klant()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
