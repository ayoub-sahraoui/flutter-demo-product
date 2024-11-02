import 'package:flutter/material.dart';
import 'package:flutter_demo/models/product.dart';
import 'package:flutter_demo/screens/add_product_dialog.dart';
import 'package:flutter_demo/screens/product_item.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> _products = [
    Product(
      id: 1,
      libelle: "Apple iPhone 13",
      description: "6.1-inch display, A15 Bionic chip, 128GB storage",
      prix: 799.0,
      photo: "assets/images/1.jpg",
    ),
    Product(
      id: 2,
      libelle: "Samsung Galaxy S21",
      description: "6.2-inch display, Exynos 2100, 128GB storage",
      prix: 699.0,
      photo: "assets/images/2.jpg",
    ),
    Product(
      id: 3,
      libelle: "Sony WH-1000XM4 Headphones",
      description: "Wireless noise-canceling headphones",
      prix: 349.0,
      photo: "assets/images/3.jpg",
    ),
  ];

  final List<int> _selectedProductsIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addProduct,
          ),
          IconButton(
            onPressed: _deleteSelectedProducts,
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return ProductItem(
              isSelected: _selectedProductsIds.contains(product.id),
              product: product,
              onDelete: () => _deleteProduct(product.id),
              onSelected: (product, isSelected) =>
                  _selectionChanged(product.id, isSelected),
            );
          },
        ),
      ),
    );
  }

  void _deleteSelectedProducts() {
    setState(() {
      _products
          .removeWhere((product) => _selectedProductsIds.contains(product.id));
      _selectedProductsIds.clear();
    });
  }

  void _selectionChanged(int id, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        _selectedProductsIds.add(id);
      } else {
        _selectedProductsIds.remove(id);
      }
    });
  }

  void _deleteProduct(int productId) {
    setState(() {
      _products.removeWhere((product) => product.id == productId);
    });
  }

  void _addProduct() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddProductDialog(),
    );
    if (result != null) {
      setState(() {
        _products.add(Product(
          id: _products.length + 1,
          libelle: result['libelle'],
          description: result['description'],
          prix: result['prix'],
          photo: result['photo'],
        ));
      });
    }
  }
}
