import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductItem extends StatefulWidget {
  ProductItem(
      {super.key,
      required this.name,
      required this.onDelete,
      required this.onSelected});

  final String name;
  final VoidCallback onDelete;
  final Function(String, bool?) onSelected;
  bool isSelected = false;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.onDelete(),
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
            Checkbox(
              value: widget.isSelected,
              onChanged: (isSelected) {
                setState(() {
                  widget.onSelected(widget.name, isSelected);
                  widget.isSelected = isSelected!;
                });
              },
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
