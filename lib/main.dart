import 'package:flutter/material.dart';
import 'package:flutter_demo/data/base.dart';
import 'package:flutter_demo/data/daos/produit_dao.dart';
import 'package:flutter_demo/screens/products_list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  final getIt = GetIt.instance;
  final database = ProduitsDatabase();
  getIt.registerSingleton<ProduitsDatabase>(database);
  getIt.registerSingleton<ProduitDAO>(ProduitDAO(database));

  // Insert some dummy data
  final produit1 = ProduitsCompanion.insert(
    libelle: 'Smartphone Galaxy S23',
    description:
        'A powerful smartphone with a 6.8-inch display, 12GB RAM, and 256GB storage.',
    photo: 'assets/images/1.png',
    prix: 999.99,
  );

  final produit2 = ProduitsCompanion.insert(
    libelle: 'Wireless Earbuds Pro',
    description:
        'Noise-canceling wireless earbuds with a 24-hour battery life and quick charging.',
    photo: 'assets/images/2.png',
    prix: 199.99,
  );

  final produit3 = ProduitsCompanion.insert(
    libelle: 'Gaming Laptop GX15',
    description:
        'A high-performance laptop with a 15.6-inch display, NVIDIA RTX 3070, and 16GB RAM.',
    photo: 'assets/images/3.png',
    prix: 1499.99,
  );

  final produit4 = ProduitsCompanion.insert(
    libelle: 'Smartwatch Fit X',
    description:
        'A smartwatch with fitness tracking, heart rate monitoring, and 10-day battery life.',
    photo: 'assets/images/4.png',
    prix: 249.99,
  );

  final produit5 = ProduitsCompanion.insert(
    libelle: 'Bluetooth Speaker Blast',
    description:
        'A portable Bluetooth speaker with a 12-hour battery life and deep bass sound.',
    photo: 'assets/images/5.png',
    prix: 89.99,
  );

  getIt.get<ProduitDAO>().insertProduit(produit1);
  getIt.get<ProduitDAO>().insertProduit(produit2);
  getIt.get<ProduitDAO>().insertProduit(produit3);
  getIt.get<ProduitDAO>().insertProduit(produit4);
  getIt.get<ProduitDAO>().insertProduit(produit5);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductsList(),
    );
  }
}
