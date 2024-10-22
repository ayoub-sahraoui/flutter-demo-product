import 'package:flutter/material.dart';

class AddProductDialog extends StatelessWidget {
  AddProductDialog({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Product name"),
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
            Navigator.of(context).pop(_controller.text);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
