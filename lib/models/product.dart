class Product {
  int id;
  String libelle;
  String description;
  double prix;
  String photo;

  Product({
    required this.id,
    required this.libelle,
    required this.description,
    required this.prix,
    required this.photo,
  });

  @override
  String toString() {
    return 'Product(id: $id, libelle: $libelle, description: $description, prix: $prix, photo: $photo)';
  }
}
