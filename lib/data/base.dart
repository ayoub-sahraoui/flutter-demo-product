import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'base.g.dart';

@DataClassName("Produit")
class Produits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get libelle => text().withLength(min: 2, max: 120)();
  TextColumn get description => text()();
  TextColumn get photo => text()();
  RealColumn get prix => real()();
}

@DriftDatabase(tables: [Produits])
class ProduitsDatabase extends _$ProduitsDatabase {
  ProduitsDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < to) {
            await migrator.deleteTable('produits');
            await migrator.createTable(produits);
          }
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            print("Database was created!");
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'produits.db'));
    return NativeDatabase(file);
  });
}
