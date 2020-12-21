import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:germeau_sateur/models/item.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:provider/provider.dart';

class CreateItemPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isvalid(String em) {
    String p = r'/\*(?:\*(?:\.\*\*|\*\*|\*)?|\.\*\*)?/';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(15)],
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
              FilteringTextInputFormatter.deny(RegExp(r',')),
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.deny(RegExp(r',')),
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            keyboardType: TextInputType.number,
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
            if (nameController.text.isNotEmpty &&
                sizeController.text.isNotEmpty &&
                priceController.text.isNotEmpty) {
              Item item = new Item(
                nameController.text.trim(),
                priceController.text.trim(),
                sizeController.text.trim(),
              );
              context.read<BarService>().createItem(item, auth.currentUser.uid);
              Navigator.of(context).pop();
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Invalid input'),
                      content: Text('Name, size and price cannot be empty'),
                      actions: [
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            }
          },
          child: Text('Add item'),
        ),
      ],
    ));
  }
}
