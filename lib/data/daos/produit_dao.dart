import 'package:drift/drift.dart';
import 'package:flutter_demo/data/base.dart';

@DriftAccessor(tables: [Produits])
class ProduitDAO extends DatabaseAccessor<ProduitsDatabase> {
  ProduitDAO(super.attachedDatabase);

  Future<void> insertProduit(ProduitsCompanion produit) {
    return into(attachedDatabase.produits).insert(produit);
  }

  Future<List<Produit>> getAllProduits() {
    return select(attachedDatabase.produits).get();
  }

  Stream<List<Produit>> getProduitsStream() {
    return select(attachedDatabase.produits).watch();
  }

  Future<bool> updateProduit(Produit produit) {
    return update(attachedDatabase.produits).replace(produit);
  }

  Future<int> deleteProduitById(int id) {
    return (delete(attachedDatabase.produits)..where((p) => p.id.equals(id)))
        .go();
  }

  Future<Produit> getProduitById(int id) {
    return (select(attachedDatabase.produits)..where((p) => p.id.equals(id)))
        .getSingle();
  }

  Future<void> deleteAllProduits() {
    return delete(attachedDatabase.produits).go();
  }
}
