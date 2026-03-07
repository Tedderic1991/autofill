// Concrete implementation of CustomFieldRepository backed by Drift + AppDatabase.
//
// Delegates all database operations to CustomFieldsDao. Maps Drift CustomField
// rows to CustomField domain models and vice-versa.
//
// Obtain an instance via the customFieldRepositoryProvider Riverpod provider
// defined in lib/providers/database_provider.dart.
//
// Requirements: PROF-07, PROF-08, PROF-09
import 'package:drift/drift.dart';

import '../../domain/models/custom_field.dart' as domain;
import '../../domain/repositories/custom_field_repository.dart';
import '../database/app_database.dart';
import '../database/tables/custom_fields_table.dart';

/// Concrete Drift-backed implementation of [CustomFieldRepository].
///
/// All write operations use CustomFieldsDao upsertField / softDeleteField.
/// Domain models are mapped to Drift Companion objects before writing,
/// and Drift CustomField rows are mapped back to domain models after reading.
///
/// Note on naming: Drift generates a class also named 'CustomField' in
/// app_database.g.dart. We alias the domain model import as 'domain' to
/// avoid ambiguity. The Drift-generated CustomField is referenced unqualified
/// (it is in scope from the app_database.dart part file).
class CustomFieldRepositoryImpl implements CustomFieldRepository {
  final AppDatabase _db;

  const CustomFieldRepositoryImpl(this._db);

  @override
  Future<List<domain.CustomField>> getActiveForProfile(String profileId) async {
    final rows = await _db.customFieldsDao.getActiveForProfile(profileId);
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> upsert(domain.CustomField field) {
    return _db.customFieldsDao.upsertField(_toCompanion(field));
  }

  @override
  Future<void> softDelete(String id) {
    return _db.customFieldsDao.softDeleteField(id);
  }

  // ---- Private mappers ----

  /// Maps a Drift [CustomField] row (from app_database.g.dart) to a
  /// [domain.CustomField] domain model.
  domain.CustomField _toDomain(CustomField row) {
    return domain.CustomField(
      id: row.id,
      profileId: row.profileId,
      label: row.label,
      fieldType: row.fieldType,
      value: row.value,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
      synchronized: row.synchronized,
    );
  }

  /// Maps a domain [domain.CustomField] to a Drift [CustomFieldsCompanion].
  CustomFieldsCompanion _toCompanion(domain.CustomField field) {
    return CustomFieldsCompanion(
      id: Value(field.id),
      profileId: Value(field.profileId),
      label: Value(field.label),
      fieldType: Value(field.fieldType),
      value: Value(field.value),
      createdAt: Value(field.createdAt),
      updatedAt: Value(field.updatedAt),
      deletedAt: Value(field.deletedAt),
      synchronized: Value(field.synchronized),
    );
  }
}
