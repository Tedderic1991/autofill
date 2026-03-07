// Drift table definition for family member profiles.
//
// Schema design notes:
// - UUID v4 TEXT primary key (no AUTOINCREMENT) — required for sync-readiness
//   across multiple devices; integer PKs collide when merging data from two
//   devices that independently increment from 1.
// - Soft-delete via deletedAt — never hard-delete; the Phase 2 AutofillService
//   caches profile IDs; a hard delete leaves orphaned references.
// - synchronized flag — dirty tracking for future Phase 4 cloud sync worker.
//   Starts false on every create/update, set to true by sync worker after upload.
// - All nullable text fields store ISO-8601 strings for dates (dateOfBirth)
//   so they can be sorted and compared without parsing.
//
// Source: drift.simonbinder.eu/dart_api/tables/
import 'package:drift/drift.dart';

/// Relationship of a profile to the primary account holder.
enum RelationshipTag {
  parent,
  child,
  guardian,
}

/// Drift table class for family member profiles.
///
/// Use [RelationshipTag] enum values for the [relationshipTag] column.
/// Set [avatarPath] to the local file path of a JPEG (not raw bytes — see
/// Pattern 5 in 01-RESEARCH.md for avatar storage rationale).
class Profiles extends Table {
  // UUID v4 TEXT primary key — never use INTEGER AUTOINCREMENT
  TextColumn get id => text().withLength(min: 36, max: 36)();

  // Core profile fields (all nullable except displayName and relationshipTag)
  TextColumn get displayName => text()();
  TextColumn get dateOfBirth => text().nullable()(); // ISO-8601 date string
  TextColumn get addressLine1 => text().nullable()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateProvince => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get allergies => text().nullable()(); // free-text, no structure
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  TextColumn get relationshipTag => textEnum<RelationshipTag>()();
  TextColumn get avatarPath =>
      text().nullable()(); // local file path, NOT image bytes

  // Sync-ready fields — present on every entity table in Phase 1
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synchronized =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
