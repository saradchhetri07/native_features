import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function selectImage;
  ImageInput(this.selectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;

  @override
  Widget build(BuildContext context) {
    Future<void> _takePicture() async {
      final ImagePicker picker = ImagePicker();
// // Pick an image.
      final XFile? imageFile =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
      if (imageFile != null) {
        setState(() {
          _storedImage = imageFile;
        });
        // Get the application documents directory path
        Directory appDocumentsDirectory = await sysPath.getTemporaryDirectory();
        String appDocumentsPath = appDocumentsDirectory.path;

        // Get the picked image file
        File pickedFile = File(imageFile.path);

        // Construct the destination path in the documents directory
        String fileName = imageFile.path.split('/').last;
        //String fileName = imageFile.path;
        print("filename is $fileName");
        String destinationPath = '$appDocumentsPath/$fileName';

        // Copy the image to the documents directory
        File? savedImage = await pickedFile.copy(destinationPath);

        // Now the image is saved to the documents directory with the name "fileName"
        widget.selectImage(savedImage);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  File(_storedImage!.path),
                  fit: BoxFit.cover,
                )
              : Center(child: Text("add an image")),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: Icon(Icons.camera),
                  label: Text(
                    "Take a picture",
                    style: TextStyle(fontSize: 26.0),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
