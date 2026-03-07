// Concrete implementation of ProfileRepository backed by Drift + AppDatabase.
//
// Delegates all database operations to ProfilesDao. Maps Drift Profile rows
// to FamilyProfile domain models and vice-versa.
//
// Obtain an instance via the profileRepositoryProvider Riverpod provider
// defined in lib/providers/database_provider.dart.
//
// Requirements: PROF-01, PROF-02, PROF-03, PROF-05
import 'package:drift/drift.dart';

import '../../domain/models/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../database/app_database.dart';
import '../database/tables/profiles_table.dart';

/// Concrete Drift-backed implementation of [ProfileRepository].
///
/// All write operations use the DAO's upsertProfile / softDelete methods.
/// Domain models are mapped to Drift Companion objects before writing,
/// and Drift Profile rows are mapped back to FamilyProfile after reading.
class ProfileRepositoryImpl implements ProfileRepository {
  final AppDatabase _db;

  const ProfileRepositoryImpl(this._db);

  @override
  Stream<List<FamilyProfile>> watchActive() {
    return _db.profilesDao.watchActiveProfiles().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  @override
  Future<FamilyProfile?> getById(String id) async {
    final row = await _db.profilesDao.getProfileById(id);
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<List<FamilyProfile>> getActiveWithFields() async {
    // Returns the base active profiles.
    // Custom fields join is handled by the use-case layer in Plan 04.
    final rows = await _db.profilesDao.getActiveProfiles();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<int> countActive() {
    return _db.profilesDao.countActive();
  }

  @override
  Future<void> upsert(FamilyProfile profile) {
    return _db.profilesDao.upsertProfile(_toCompanion(profile));
  }

  @override
  Future<void> softDelete(String id) {
    return _db.profilesDao.softDelete(id);
  }

  // ---- Private mappers ----

  /// Maps a Drift [Profile] row to a [FamilyProfile] domain model.
  FamilyProfile _toDomain(Profile row) {
    return FamilyProfile(
      id: row.id,
      displayName: row.displayName,
      dateOfBirth: row.dateOfBirth,
      addressLine1: row.addressLine1,
      addressLine2: row.addressLine2,
      city: row.city,
      stateProvince: row.stateProvince,
      postalCode: row.postalCode,
      country: row.country,
      phone: row.phone,
      allergies: row.allergies,
      emergencyContactName: row.emergencyContactName,
      emergencyContactPhone: row.emergencyContactPhone,
      relationshipTag: row.relationshipTag,
      avatarPath: row.avatarPath,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
      synchronized: row.synchronized,
    );
  }

  /// Maps a [FamilyProfile] domain model to a Drift [ProfilesCompanion].
  ProfilesCompanion _toCompanion(FamilyProfile profile) {
    return ProfilesCompanion(
      id: Value(profile.id),
      displayName: Value(profile.displayName),
      dateOfBirth: Value(profile.dateOfBirth),
      addressLine1: Value(profile.addressLine1),
      addressLine2: Value(profile.addressLine2),
      city: Value(profile.city),
      stateProvince: Value(profile.stateProvince),
      postalCode: Value(profile.postalCode),
      country: Value(profile.country),
      phone: Value(profile.phone),
      allergies: Value(profile.allergies),
      emergencyContactName: Value(profile.emergencyContactName),
      emergencyContactPhone: Value(profile.emergencyContactPhone),
      relationshipTag: Value(profile.relationshipTag),
      avatarPath: Value(profile.avatarPath),
      createdAt: Value(profile.createdAt),
      updatedAt: Value(profile.updatedAt),
      deletedAt: Value(profile.deletedAt),
      synchronized: Value(profile.synchronized),
    );
  }
}
