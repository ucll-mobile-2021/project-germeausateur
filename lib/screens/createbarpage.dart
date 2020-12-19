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
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
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
          },
          child: Text('Create bar'),
        )
      ],
    ));
  }
}
