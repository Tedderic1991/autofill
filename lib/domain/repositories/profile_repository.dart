// Abstract repository interface for FamilyProfile CRUD operations.
//
// All storage details are hidden behind this interface — callers depend only
// on FamilyProfile domain models, never on Drift or database types.
//
// Concrete implementation: lib/data/repositories/profile_repository_impl.dart
// Riverpod provider: lib/providers/database_provider.dart (profileRepositoryProvider)
//
// Requirements: PROF-01, PROF-02, PROF-03
import '../models/profile.dart';

/// Abstract repository interface for family member profile operations.
///
/// All write operations update [FamilyProfile.updatedAt] to the current UTC
/// time. Soft-delete sets [FamilyProfile.deletedAt] — rows are never removed.
abstract class ProfileRepository {
  /// Returns a live stream of all non-deleted profiles, sorted by displayName.
  ///
  /// Emits a new list whenever any profile is inserted, updated, or soft-deleted.
  Stream<List<FamilyProfile>> watchActive();

  /// Returns a profile by [id], or null if it does not exist.
  Future<FamilyProfile?> getById(String id);

  /// Returns all active profiles.
  ///
  /// For Plan 04+ use cases that need custom fields combined, use the use-case
  /// layer which queries both profile and custom field repositories.
  Future<List<FamilyProfile>> getActiveWithFields();

  /// Returns the count of non-deleted profiles.
  Future<int> countActive();

  /// Inserts or replaces a profile row using the profile's [id] as the key.
  ///
  /// Sets [FamilyProfile.updatedAt] to now. Creates a new row if none exists
  /// with this id; replaces the existing row if one does.
  Future<void> upsert(FamilyProfile profile);

  /// Soft-deletes a profile by setting [FamilyProfile.deletedAt] to now.
  ///
  /// The row remains in the database. [watchActive] and [countActive] will
  /// no longer include it.
  Future<void> softDelete(String id);
}
