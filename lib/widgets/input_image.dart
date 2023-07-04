import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ye dono class mei screen kon banata h

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onPickImage});
  // File? select;
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage; // want to pass this info to the add_place screen

  void takePicture() async {
    final imagePicker = ImagePicker();
    // type XFile in pickedImage

    // significance of setting height width and why max?
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    selectedImage = File(pickedImage.path); // XFile to normal file conversion
    setState(() {});

    widget.onPickImage(selectedImage!);
    // widget.select = selectedImage; why not this way, why define function?
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      onPressed: () {
        return takePicture();
      },
      label: const Text("Take Picture"),
    );

    if (selectedImage != null) {
      // significance of setting height width

      content = GestureDetector(
        onTap: () {
          return takePicture();
        },
        child: Image.file(
          selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      height: 240,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
