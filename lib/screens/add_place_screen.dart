import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/user_location.dart';
import 'package:native_features/widgets/image_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/addPlace";
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _savePlace() {
    if (_pickedImage == null || _titleController.text.isEmpty) {
      print("inside saveplace");
      return;
    }
    Provider.of<GreatPlace>(context, listen: false)
        .addPlace(_pickedImage!, _titleController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("User inputs..."),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(label: Text('new title')),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ImageInput(selectImage),
                  SizedBox(
                    height: 20.0,
                  ),
                  UserLocation()
                ],
              ),
            )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
            child: ElevatedButton.icon(
              onPressed: () => _savePlace(),
              icon: const Icon(Icons.add),
              label: const Text('add Place'),
            ),
          )
        ],
      ),
    );
  }
}
