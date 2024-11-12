import 'package:flutter/material.dart';
import 'package:flutter_demo/data/base.dart';
import 'package:flutter_demo/data/daos/produit_dao.dart';
import 'package:flutter_demo/screens/add_product_dialog.dart';
import 'package:flutter_demo/screens/product_item.dart';
import 'package:get_it/get_it.dart';

class ProductsList extends StatelessWidget {
  ProductsList({super.key});
  final ProduitDAO _produitDAO = GetIt.instance.get<ProduitDAO>();

  void _addProduct(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddProductDialog(),
    );

    if (result != null) {
      final produit = ProduitsCompanion.insert(
        libelle: result['libelle'],
        description: result['description'],
        photo: result['photo'],
        prix: result['prix'],
      );
      _produitDAO.insertProduit(produit);
    }
  }

  Future<void> _deleteAllProducts() async {
    await _produitDAO.deleteAllProduits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              _addProduct(context);
            },
          ),
          IconButton(
            onPressed: () {
              _deleteAllProducts();
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StreamBuilder(
          stream: _produitDAO.getProduitsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final produits = snapshot.data!;
              if (produits.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning, size: 50, color: Colors.grey),
                      const SizedBox(height: 10),
                      const Text("No products found",
                          style: TextStyle(fontSize: 20)),
                      const Text("Add a product to get started",
                          style: TextStyle(fontSize: 12)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          _addProduct(context);
                        },
                        child: const Text("Add Product"),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: produits.length,
                itemBuilder: (context, index) {
                  final produit = produits[index];
                  return ProductItem(
                    product: produit,
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
