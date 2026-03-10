// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_fields_dao.dart';

// ignore_for_file: type=lint
mixin _$CustomFieldsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $CustomFieldsTable get customFields => attachedDatabase.customFields;
  CustomFieldsDaoManager get managers => CustomFieldsDaoManager(this);
}

class CustomFieldsDaoManager {
  final _$CustomFieldsDaoMixin _db;
  CustomFieldsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$CustomFieldsTableTableManager get customFields =>
      $$CustomFieldsTableTableManager(_db.attachedDatabase, _db.customFields);
}
