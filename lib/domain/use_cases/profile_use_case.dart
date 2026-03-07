// Profile business-logic use case.
//
// ProfileUseCase is the authoritative source of profile mutation logic.
// The UI layer (Plan 05) and any other callers must go through this class —
// never call ProfileRepository directly for create/update/delete.
//
// Entitlement gating: free-tier users are capped at 2 active profiles.
// Phase 4 replaces entitlementTierProvider to lift the cap for paid users.
//
// Requirements: PROF-06 (freemium cap), PROF-01/02/03 (CRUD with sync fields)

import 'package:uuid/uuid.dart';

import '../models/profile.dart';
import '../repositories/profile_repository.dart';
import '../../providers/entitlement_providers.dart';

// ── Exception classes ────────────────────────────────────────────────────────

/// Thrown when a free-tier user attempts to create a 3rd profile.
///
/// UI should catch this and offer the user an upgrade flow.
class ProfileLimitReached implements Exception {
  const ProfileLimitReached();

  @override
  String toString() =>
      'ProfileLimitReached: free tier allows up to ${ProfileUseCase.freeTierLimit} active profiles';
}

/// Thrown when [ProfileUseCase.updateProfile] is called with an id that does
/// not exist in the repository.
class ProfileNotFound implements Exception {
  const ProfileNotFound(this.id);

  final String id;

  @override
  String toString() => 'ProfileNotFound: no profile with id=$id';
}

// ── Use case ─────────────────────────────────────────────────────────────────

/// Business logic for profile CRUD with freemium cap enforcement.
///
/// Constructor injection keeps this class testable with mock repositories
/// and mock entitlement tiers (no Riverpod coupling in this class itself).
class ProfileUseCase {
  final ProfileRepository _repo;
  final EntitlementTier _tier;

  /// Maximum number of active profiles on the free tier.
  static const int freeTierLimit = 2;

  const ProfileUseCase(this._repo, this._tier);

  // ── createProfile ──────────────────────────────────────────────────────────

  /// Creates a new [FamilyProfile] from [request].
  ///
  /// Throws [ProfileLimitReached] if the user is on the free tier and already
  /// has [freeTierLimit] or more active profiles.
  ///
  /// Sets: `id` = UUID v4, `createdAt`/`updatedAt` = now UTC,
  /// `synchronized` = false, `deletedAt` = null.
  Future<FamilyProfile> createProfile(ProfileCreateRequest request) async {
    // Enforce free-tier cap (paid tier bypasses the check entirely)
    if (_tier == EntitlementTier.free) {
      final count = await _repo.countActive();
      if (count >= freeTierLimit) {
        throw const ProfileLimitReached();
      }
    }

    final now = DateTime.now().toUtc();
    final profile = FamilyProfile(
      id: const Uuid().v4(),
      displayName: request.displayName,
      dateOfBirth: request.dateOfBirth,
      addressLine1: request.addressLine1,
      addressLine2: request.addressLine2,
      city: request.city,
      stateProvince: request.stateProvince,
      postalCode: request.postalCode,
      country: request.country,
      phone: request.phone,
      allergies: request.allergies,
      emergencyContactName: request.emergencyContactName,
      emergencyContactPhone: request.emergencyContactPhone,
      relationshipTag: request.relationshipTag,
      avatarPath: request.avatarPath,
      createdAt: now,
      updatedAt: now,
      deletedAt: null,
      synchronized: false,
    );

    await _repo.upsert(profile);
    return profile;
  }

  // ── updateProfile ──────────────────────────────────────────────────────────

  /// Updates an existing profile with the fields in [request].
  ///
  /// Only non-null fields in [request] replace the current values.
  /// Always sets `updatedAt` = now UTC and `synchronized` = false.
  ///
  /// Throws [ProfileNotFound] if no profile exists with [id].
  Future<FamilyProfile> updateProfile(
      String id, ProfileUpdateRequest request) async {
    final existing = await _repo.getById(id);
    if (existing == null) {
      throw ProfileNotFound(id);
    }

    final updated = existing.copyWith(
      displayName: request.displayName ?? existing.displayName,
      dateOfBirth: request.dateOfBirth ?? existing.dateOfBirth,
      addressLine1: request.addressLine1 ?? existing.addressLine1,
      addressLine2: request.addressLine2 ?? existing.addressLine2,
      city: request.city ?? existing.city,
      stateProvince: request.stateProvince ?? existing.stateProvince,
      postalCode: request.postalCode ?? existing.postalCode,
      country: request.country ?? existing.country,
      phone: request.phone ?? existing.phone,
      allergies: request.allergies ?? existing.allergies,
      emergencyContactName:
          request.emergencyContactName ?? existing.emergencyContactName,
      emergencyContactPhone:
          request.emergencyContactPhone ?? existing.emergencyContactPhone,
      relationshipTag: request.relationshipTag ?? existing.relationshipTag,
      avatarPath: request.avatarPath ?? existing.avatarPath,
      updatedAt: DateTime.now().toUtc(),
      synchronized: false,
    );

    await _repo.upsert(updated);
    return updated;
  }

  // ── deleteProfile ──────────────────────────────────────────────────────────

  /// Soft-deletes the profile with [id].
  ///
  /// Delegates to [ProfileRepository.softDelete] — the row is never removed.
  /// Custom fields are NOT cascaded here; their soft-delete is handled by
  /// [CustomFieldUseCase] or can be enforced via DB FK constraints.
  Future<void> deleteProfile(String id) async {
    await _repo.softDelete(id);
  }
}
