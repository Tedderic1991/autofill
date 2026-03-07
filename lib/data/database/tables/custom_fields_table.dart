// Drift table definition for user-defined custom fields on profiles.
//
// Each custom field belongs to exactly one profile (FK on profileId).
// Storing custom fields in a separate normalized table (not a JSON blob)
// allows the Phase 2 AutofillService to iterate fields by type and query
// `SELECT * FROM custom_fields WHERE profile_id = ?` directly.
//
// Source: drift.simonbinder.eu/dart_api/tables/
// Pitfall #6 from 01-RESEARCH.md: do NOT store custom fields as JSON blob.
import 'package:drift/drift.dart';

import 'profiles_table.dart';

/// Type of a custom field value.
enum CustomFieldType {
  text,
  number,
  date,
}

/// Drift table class for user-defined custom fields on family profiles.
///
/// Each row is a single custom field attached to a profile via [profileId].
/// [fieldType] determines how the [value] string should be interpreted:
/// - [CustomFieldType.text]: arbitrary string
/// - [CustomFieldType.number]: numeric string (e.g. "42")
/// - [CustomFieldType.date]: ISO-8601 date string (e.g. "2024-01-15")
class CustomFields extends Table {
  // UUID v4 TEXT primary key — same pattern as Profiles
  TextColumn get id => text().withLength(min: 36, max: 36)();

  // FK → Profiles.id; cascade delete handled at use-case layer via soft delete
  TextColumn get profileId => text().references(Profiles, #id)();

  // Field definition
  TextColumn get label => text()();
  TextColumn get fieldType => textEnum<CustomFieldType>()();
  TextColumn get value => text().nullable()();

  // Sync-ready fields — same four columns on every entity table
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synchronized =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
