import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:provider/provider.dart';

class CreateItemPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Name',
              fillColor: Colors.grey[800],
              filled: true,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: priceController,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Price',
              fillColor: Colors.grey[800],
              filled: true,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: sizeController,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Size',
              fillColor: Colors.grey[800],
              filled: true,
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            Item item = new Item(
              nameController.text.trim(),
              priceController.text.trim(),
              sizeController.text.trim(),
            );
            context.read<BarService>().createItem(item, auth.currentUser.uid);
            Navigator.of(context).pop();
          },
          child: Text('Add item'),
        ),
      ],
    ));
  }
}
