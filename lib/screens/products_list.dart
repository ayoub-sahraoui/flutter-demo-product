import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/add_product_dialog.dart';
import 'package:flutter_demo/screens/product_item.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<String> _products = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry",
    "Fig",
    "Grape",
    "Honeydew",
    "Jackfruit",
    "Kiwi",
    "Lemon",
    "Mango",
    "Nectarine",
    "Orange",
    "Papaya",
    "Quince",
    "Raspberry",
    "Strawberry",
    "Tangerine",
    "Ugli fruit",
    "Vanilla bean",
    "Watermelon",
    "Ximenia caffra",
    "Yuzu",
    "Zucchini",
  ];
  final List<String> _selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addProduct();
            },
          ),
          IconButton(
              onPressed: () {
                _deleteSelectedProducts();
              },
              icon: const Icon(Icons.delete_forever)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return ProductItem(
              name: _products[index],
              onDelete: () {
                _deleteProduct(index);
              },
              onSelected: _selectionChanged,
            );
          },
        ),
      ),
    );
  }

  void _deleteSelectedProducts() {
    final List<String> newProducts = List.from(_products);
    for (final product in _selectedProducts) {
      newProducts.remove(product);
    }

    setState(() {
      _products = newProducts;
      _selectedProducts.clear();
    });
  }

  void _selectionChanged(String name, bool? isSelected) {
    if (isSelected == true) {
      _selectedProducts.add(name);
    } else {
      _selectedProducts.remove(name);
    }
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _addProduct() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AddProductDialog(),
    );
    if (result != null) {
      setState(() {
        _products.add(result);
      });
    }
  }
}
