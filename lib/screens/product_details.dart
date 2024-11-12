import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/data/base.dart';

class ProductDetails extends StatelessWidget {
  final Produit product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.libelle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.photo.isNotEmpty)
                Center(
                  child: product.photo.startsWith("assets")
                      ? Image.asset(product.photo)
                      : Image.file(File(product.photo)),
                ),
              const SizedBox(height: 20),
              Text(
                'Name: ${product.libelle}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${product.description}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: ${product.prix}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
