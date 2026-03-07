// Custom field business-logic use case.
//
// CustomFieldUseCase is the authoritative source for custom field mutations.
// The UI layer (Plan 05) must go through this class — never call
// CustomFieldRepository directly for create/update/delete.
//
// Requirements: PROF-07 (add field), PROF-08 (edit/delete field), PROF-09 (read)

import 'package:uuid/uuid.dart';

import '../models/custom_field.dart';
import '../repositories/custom_field_repository.dart';

// ── Exception classes ────────────────────────────────────────────────────────

/// Thrown when [CustomFieldUseCase.editField] is called with an id that does
/// not exist in the repository for the given profile.
class CustomFieldNotFound implements Exception {
  const CustomFieldNotFound(this.fieldId);

  final String fieldId;

  @override
  String toString() => 'CustomFieldNotFound: no active field with id=$fieldId';
}

// ── Use case ─────────────────────────────────────────────────────────────────

/// Business logic for custom field CRUD operations.
///
/// Constructor injection keeps this class testable with mock repositories.
class CustomFieldUseCase {
  final CustomFieldRepository _repo;

  const CustomFieldUseCase(this._repo);

  // ── addField ───────────────────────────────────────────────────────────────

  /// Creates a new [CustomField] linked to [profileId].
  ///
  /// Sets: `id` = UUID v4, `createdAt`/`updatedAt` = now UTC,
  /// `synchronized` = false, `deletedAt` = null.
  Future<CustomField> addField(
    String profileId,
    String label,
    CustomFieldType fieldType,
  ) async {
    final now = DateTime.now().toUtc();
    final field = CustomField(
      id: const Uuid().v4(),
      profileId: profileId,
      label: label,
      fieldType: fieldType,
      value: null,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
      synchronized: false,
    );

    await _repo.upsert(field);
    return field;
  }

  // ── editField ──────────────────────────────────────────────────────────────

  /// Updates an existing custom field identified by [fieldId].
  ///
  /// [profileId] is required to locate the field via [CustomFieldRepository.getActiveForProfile].
  /// Only non-null parameters replace the current values.
  /// Always sets `updatedAt` = now UTC and `synchronized` = false.
  ///
  /// Throws [CustomFieldNotFound] if no active field exists with [fieldId].
  Future<CustomField> editField(
    String fieldId, {
    required String profileId,
    String? label,
    CustomFieldType? fieldType,
    String? value,
  }) async {
    // Locate the field by scanning the profile's active fields.
    // (CustomFieldRepository does not expose getById — this is sufficient for
    // the expected use case where a profile has a bounded number of fields.)
    final fields = await _repo.getActiveForProfile(profileId);
    final existing = fields.cast<CustomField?>().firstWhere(
          (f) => f?.id == fieldId,
          orElse: () => null,
        );

    if (existing == null) {
      throw CustomFieldNotFound(fieldId);
    }

    final updated = existing.copyWith(
      label: label ?? existing.label,
      fieldType: fieldType ?? existing.fieldType,
      value: value ?? existing.value,
      updatedAt: DateTime.now().toUtc(),
      synchronized: false,
    );

    await _repo.upsert(updated);
    return updated;
  }

  // ── deleteField ────────────────────────────────────────────────────────────

  /// Soft-deletes the custom field with [fieldId].
  ///
  /// Delegates to [CustomFieldRepository.softDelete] — the row is never removed.
  Future<void> deleteField(String fieldId) async {
    await _repo.softDelete(fieldId);
  }
}
