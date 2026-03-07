// Abstract repository interface for CustomField CRUD operations.
//
// All storage details are hidden behind this interface — callers depend only
// on CustomField domain models, never on Drift or database types.
//
// Concrete implementation: lib/data/repositories/custom_field_repository_impl.dart
// Riverpod provider: lib/providers/database_provider.dart (customFieldRepositoryProvider)
//
// Requirements: PROF-07, PROF-08, PROF-09
import '../models/custom_field.dart';

/// Abstract repository interface for user-defined custom field operations.
///
/// Custom fields belong to a specific profile (linked by profileId).
/// All write operations update [CustomField.updatedAt] to the current UTC time.
/// Soft-delete sets [CustomField.deletedAt] — rows are never removed.
abstract class CustomFieldRepository {
  /// Returns all active (non-deleted) custom fields for a given profile.
  Future<List<CustomField>> getActiveForProfile(String profileId);

  /// Inserts or replaces a custom field row using the field's [id] as the key.
  ///
  /// Sets [CustomField.updatedAt] to now. Creates a new row if none exists
  /// with this id; replaces the existing row if one does.
  Future<void> upsert(CustomField field);

  /// Soft-deletes a custom field by setting [CustomField.deletedAt] to now.
  ///
  /// The row remains in the database. [getActiveForProfile] will no longer
  /// return it.
  Future<void> softDelete(String id);
}
