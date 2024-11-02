import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddProductDialog extends StatefulWidget {
  AddProductDialog({super.key});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController _libelleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  File? _photoFile;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _photoFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _libelleController,
              decoration: const InputDecoration(hintText: "Product name"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            TextField(
              controller: _prixController,
              decoration: const InputDecoration(hintText: "Price"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            if (_photoFile != null)
              Image.file(
                _photoFile!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            else
              const Text("No image selected"),
            TextButton(
              onPressed: _pickImage,
              child: const Text("Select Photo"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            final productData = {
              "libelle": _libelleController.text,
              "description": _descriptionController.text,
              "prix": double.tryParse(_prixController.text) ?? 0.0,
              "photo": _photoFile?.path ?? '', // Return file path if selected
            };
            Navigator.of(context).pop(productData);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
