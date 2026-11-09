import 'package:drift/drift.dart';

import 'products.dart';

// Home product rows; the title comes from ARB by [type]. Added in v3.
@DataClassName('SectionRow')
class Sections extends Table {
  TextColumn get id => text()();

  /// seasonal, popular or orderAgain.
  TextColumn get type => text()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// Which products a section shows, in order.
@DataClassName('SectionProductRow')
class SectionProducts extends Table {
  TextColumn get sectionId =>
      text().references(Sections, #id, onDelete: KeyAction.cascade)();
  TextColumn get productId =>
      text().references(Products, #id, onDelete: KeyAction.cascade)();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {sectionId, productId};
}
