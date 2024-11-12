import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/data/base.dart';
import 'package:flutter_demo/data/daos/produit_dao.dart';
import 'package:flutter_demo/models/product.dart';
import 'package:flutter_demo/screens/product_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';

class ProductItem extends StatefulWidget {
  ProductItem({
    super.key,
    required this.product,
  });

  final Produit product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ProductDetails(product: widget.product)),
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                GetIt.instance
                    .get<ProduitDAO>()
                    .deleteProduitById(widget.product.id);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (widget.product.photo.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: widget.product.photo.startsWith('assets')
                          ? AssetImage(widget.product.photo)
                          : FileImage(File(widget.product.photo)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, size: 30, color: Colors.grey),
                ),
              Expanded(
                child: Text(
                  widget.product.libelle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
