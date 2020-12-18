import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/services/itemservice.dart';
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
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: priceController,
          decoration: InputDecoration(
            labelText: 'Price',
          ),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: sizeController,
          decoration: InputDecoration(
            labelText: 'Size',
          ),
        ),
        RaisedButton(
          onPressed: () {
            Item item = new Item(
              nameController.text.trim(),
              priceController.text.trim(),
              sizeController.text.trim(),
            );
            context.read<ItemService>().createItem(item);
          },
          child: Text('Add item'),
        )
      ],
    ));
  }
}
