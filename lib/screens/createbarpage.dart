import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:germeau_sateur/models/bar.dart';
import 'package:germeau_sateur/services/barservice.dart';
import 'package:provider/provider.dart';

class CreateBarPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              fillColor: Colors.grey[800],
              filled: true,
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            Bar bar = new Bar(
              auth.currentUser.uid,
              nameController.text.trim(),
              descriptionController.text.trim(),
            );
            context.read<BarService>().createBar(bar, auth.currentUser.uid);
            Navigator.of(context).pop();
          },
          child: Text('Create bar'),
        )
      ],
    ));
  }
}
