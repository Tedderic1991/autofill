// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
// **************************************************************************
// NOTE: This file was hand-authored because build_runner cannot run in the
// current environment (Flutter/Dart SDK not installed). When Flutter SDK is
// available, regenerate by running:
//   flutter pub run build_runner build --delete-conflicting-outputs
// **************************************************************************

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
mixin _$ProfilesDatabaseMixin {}

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String displayName;
  final String? dateOfBirth;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? stateProvince;
  final String? postalCode;
  final String? country;
  final String? phone;
  final String? allergies;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final RelationshipTag relationshipTag;
  final String? avatarPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synchronized;

  const Profile({
    required this.id,
    required this.displayName,
    this.dateOfBirth,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.phone,
    this.allergies,
    this.emergencyContactName,
    this.emergencyContactPhone,
    required this.relationshipTag,
    this.avatarPath,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.synchronized,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || addressLine1 != null) {
      map['address_line1'] = Variable<String>(addressLine1);
    }
    if (!nullToAbsent || addressLine2 != null) {
      map['address_line2'] = Variable<String>(addressLine2);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || stateProvince != null) {
      map['state_province'] = Variable<String>(stateProvince);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || emergencyContactName != null) {
      map['emergency_contact_name'] = Variable<String>(emergencyContactName);
    }
    if (!nullToAbsent || emergencyContactPhone != null) {
      map['emergency_contact_phone'] = Variable<String>(emergencyContactPhone);
    }
    {
      final converter = $ProfilesTable.$converterrelationshipTag;
      map['relationship_tag'] = Variable<String>(converter.toSql(relationshipTag));
    }
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synchronized'] = Variable<bool>(synchronized);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      displayName: Value(displayName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      addressLine1: addressLine1 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine1),
      addressLine2: addressLine2 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine2),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      stateProvince: stateProvince == null && nullToAbsent
          ? const Value.absent()
          : Value(stateProvince),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      emergencyContactName: emergencyContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactName),
      emergencyContactPhone: emergencyContactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactPhone),
      relationshipTag: Value(relationshipTag),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synchronized: Value(synchronized),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      addressLine1: serializer.fromJson<String?>(json['addressLine1']),
      addressLine2: serializer.fromJson<String?>(json['addressLine2']),
      city: serializer.fromJson<String?>(json['city']),
      stateProvince: serializer.fromJson<String?>(json['stateProvince']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      country: serializer.fromJson<String?>(json['country']),
      phone: serializer.fromJson<String?>(json['phone']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      emergencyContactName:
          serializer.fromJson<String?>(json['emergencyContactName']),
      emergencyContactPhone:
          serializer.fromJson<String?>(json['emergencyContactPhone']),
      relationshipTag: $ProfilesTable.$converterrelationshipTag
          .fromJson(serializer.fromJson<String>(json['relationshipTag'])),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synchronized: serializer.fromJson<bool>(json['synchronized']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'addressLine1': serializer.toJson<String?>(addressLine1),
      'addressLine2': serializer.toJson<String?>(addressLine2),
      'city': serializer.toJson<String?>(city),
      'stateProvince': serializer.toJson<String?>(stateProvince),
      'postalCode': serializer.toJson<String?>(postalCode),
      'country': serializer.toJson<String?>(country),
      'phone': serializer.toJson<String?>(phone),
      'allergies': serializer.toJson<String?>(allergies),
      'emergencyContactName':
          serializer.toJson<String?>(emergencyContactName),
      'emergencyContactPhone':
          serializer.toJson<String?>(emergencyContactPhone),
      'relationshipTag': serializer.toJson<String>(
          $ProfilesTable.$converterrelationshipTag.toJson(relationshipTag)),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synchronized': serializer.toJson<bool>(synchronized),
    };
  }

  Profile copyWith({
    String? id,
    String? displayName,
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> addressLine1 = const Value.absent(),
    Value<String?> addressLine2 = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> stateProvince = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> emergencyContactName = const Value.absent(),
    Value<String?> emergencyContactPhone = const Value.absent(),
    RelationshipTag? relationshipTag,
    Value<String?> avatarPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? synchronized,
  }) =>
      Profile(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        addressLine1:
            addressLine1.present ? addressLine1.value : this.addressLine1,
        addressLine2:
            addressLine2.present ? addressLine2.value : this.addressLine2,
        city: city.present ? city.value : this.city,
        stateProvince:
            stateProvince.present ? stateProvince.value : this.stateProvince,
        postalCode: postalCode.present ? postalCode.value : this.postalCode,
        country: country.present ? country.value : this.country,
        phone: phone.present ? phone.value : this.phone,
        allergies: allergies.present ? allergies.value : this.allergies,
        emergencyContactName: emergencyContactName.present
            ? emergencyContactName.value
            : this.emergencyContactName,
        emergencyContactPhone: emergencyContactPhone.present
            ? emergencyContactPhone.value
            : this.emergencyContactPhone,
        relationshipTag: relationshipTag ?? this.relationshipTag,
        avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synchronized: synchronized ?? this.synchronized,
      );

  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      city: data.city.present ? data.city.value : this.city,
      stateProvince: data.stateProvince.present
          ? data.stateProvince.value
          : this.stateProvince,
      postalCode:
          data.postalCode.present ? data.postalCode.value : this.postalCode,
      country: data.country.present ? data.country.value : this.country,
      phone: data.phone.present ? data.phone.value : this.phone,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      emergencyContactName: data.emergencyContactName.present
          ? data.emergencyContactName.value
          : this.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone.present
          ? data.emergencyContactPhone.value
          : this.emergencyContactPhone,
      relationshipTag: data.relationshipTag.present
          ? data.relationshipTag.value
          : this.relationshipTag,
      avatarPath:
          data.avatarPath.present ? data.avatarPath.value : this.avatarPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synchronized: data.synchronized.present
          ? data.synchronized.value
          : this.synchronized,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('allergies: $allergies, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('relationshipTag: $relationshipTag, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synchronized: $synchronized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        displayName,
        dateOfBirth,
        addressLine1,
        addressLine2,
        city,
        stateProvince,
        postalCode,
        country,
        phone,
        allergies,
        emergencyContactName,
        emergencyContactPhone,
        relationshipTag,
        avatarPath,
        createdAt,
        updatedAt,
        deletedAt,
        synchronized,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.city == this.city &&
          other.stateProvince == this.stateProvince &&
          other.postalCode == this.postalCode &&
          other.country == this.country &&
          other.phone == this.phone &&
          other.allergies == this.allergies &&
          other.emergencyContactName == this.emergencyContactName &&
          other.emergencyContactPhone == this.emergencyContactPhone &&
          other.relationshipTag == this.relationshipTag &&
          other.avatarPath == this.avatarPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synchronized == this.synchronized);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String?> dateOfBirth;
  final Value<String?> addressLine1;
  final Value<String?> addressLine2;
  final Value<String?> city;
  final Value<String?> stateProvince;
  final Value<String?> postalCode;
  final Value<String?> country;
  final Value<String?> phone;
  final Value<String?> allergies;
  final Value<String?> emergencyContactName;
  final Value<String?> emergencyContactPhone;
  final Value<RelationshipTag> relationshipTag;
  final Value<String?> avatarPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synchronized;
  final Value<int> rowid;

  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.stateProvince = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.country = const Value.absent(),
    this.phone = const Value.absent(),
    this.allergies = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.relationshipTag = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synchronized = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  ProfilesCompanion.insert({
    required String id,
    required String displayName,
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> addressLine1 = const Value.absent(),
    Value<String?> addressLine2 = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> stateProvince = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> emergencyContactName = const Value.absent(),
    Value<String?> emergencyContactPhone = const Value.absent(),
    required RelationshipTag relationshipTag,
    Value<String?> avatarPath = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<bool> synchronized = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        displayName = Value(displayName),
        dateOfBirth = dateOfBirth,
        addressLine1 = addressLine1,
        addressLine2 = addressLine2,
        city = city,
        stateProvince = stateProvince,
        postalCode = postalCode,
        country = country,
        phone = phone,
        allergies = allergies,
        emergencyContactName = emergencyContactName,
        emergencyContactPhone = emergencyContactPhone,
        relationshipTag = Value(relationshipTag),
        avatarPath = avatarPath,
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        deletedAt = deletedAt,
        synchronized = synchronized;

  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? dateOfBirth,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? city,
    Expression<String>? stateProvince,
    Expression<String>? postalCode,
    Expression<String>? country,
    Expression<String>? phone,
    Expression<String>? allergies,
    Expression<String>? emergencyContactName,
    Expression<String>? emergencyContactPhone,
    Expression<String>? relationshipTag,
    Expression<String>? avatarPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synchronized,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (city != null) 'city': city,
      if (stateProvince != null) 'state_province': stateProvince,
      if (postalCode != null) 'postal_code': postalCode,
      if (country != null) 'country': country,
      if (phone != null) 'phone': phone,
      if (allergies != null) 'allergies': allergies,
      if (emergencyContactName != null)
        'emergency_contact_name': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergency_contact_phone': emergencyContactPhone,
      if (relationshipTag != null) 'relationship_tag': relationshipTag,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synchronized != null) 'synchronized': synchronized,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String?>? dateOfBirth,
    Value<String?>? addressLine1,
    Value<String?>? addressLine2,
    Value<String?>? city,
    Value<String?>? stateProvince,
    Value<String?>? postalCode,
    Value<String?>? country,
    Value<String?>? phone,
    Value<String?>? allergies,
    Value<String?>? emergencyContactName,
    Value<String?>? emergencyContactPhone,
    Value<RelationshipTag>? relationshipTag,
    Value<String?>? avatarPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? synchronized,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      stateProvince: stateProvince ?? this.stateProvince,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      allergies: allergies ?? this.allergies,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      relationshipTag: relationshipTag ?? this.relationshipTag,
      avatarPath: avatarPath ?? this.avatarPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synchronized: synchronized ?? this.synchronized,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (stateProvince.present) {
      map['state_province'] = Variable<String>(stateProvince.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (emergencyContactName.present) {
      map['emergency_contact_name'] =
          Variable<String>(emergencyContactName.value);
    }
    if (emergencyContactPhone.present) {
      map['emergency_contact_phone'] =
          Variable<String>(emergencyContactPhone.value);
    }
    if (relationshipTag.present) {
      final converter = $ProfilesTable.$converterrelationshipTag;
      map['relationship_tag'] =
          Variable<String>(converter.toSql(relationshipTag.value));
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synchronized.present) {
      map['synchronized'] = Variable<bool>(synchronized.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('stateProvince: $stateProvince, ')
          ..write('postalCode: $postalCode, ')
          ..write('country: $country, ')
          ..write('phone: $phone, ')
          ..write('allergies: $allergies, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('relationshipTag: $relationshipTag, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synchronized: $synchronized, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $ProfilesTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);

  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _addressLine1Meta =
      const VerificationMeta('addressLine1');
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
      'address_line1', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _addressLine2Meta =
      const VerificationMeta('addressLine2');
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
      'address_line2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _stateProvinceMeta =
      const VerificationMeta('stateProvince');
  @override
  late final GeneratedColumn<String> stateProvince = GeneratedColumn<String>(
      'state_province', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _postalCodeMeta =
      const VerificationMeta('postalCode');
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
      'postal_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _allergiesMeta =
      const VerificationMeta('allergies');
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
      'allergies', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _emergencyContactNameMeta =
      const VerificationMeta('emergencyContactName');
  @override
  late final GeneratedColumn<String> emergencyContactName =
      GeneratedColumn<String>('emergency_contact_name', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _emergencyContactPhoneMeta =
      const VerificationMeta('emergencyContactPhone');
  @override
  late final GeneratedColumn<String> emergencyContactPhone =
      GeneratedColumn<String>('emergency_contact_phone', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _relationshipTagMeta =
      const VerificationMeta('relationshipTag');
  @override
  late final GeneratedColumnWithTypeConverter<RelationshipTag, String>
      relationshipTag = GeneratedColumnWithTypeConverter<RelationshipTag,
              String>('relationship_tag', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          converter: $ProfilesTable.$converterrelationshipTag);

  static const VerificationMeta _avatarPathMeta =
      const VerificationMeta('avatarPath');
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
      'avatar_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);

  static const VerificationMeta _synchronizedMeta =
      const VerificationMeta('synchronized');
  @override
  late final GeneratedColumn<bool> synchronized = GeneratedColumn<bool>(
      'synchronized', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));

  static JsonTypeConverter2<RelationshipTag, String, String>
      $converterrelationshipTag =
      const EnumNameConverter<RelationshipTag>(RelationshipTag.values);

  @override
  List<GeneratedColumn> get $columns => [
        id,
        displayName,
        dateOfBirth,
        addressLine1,
        addressLine2,
        city,
        stateProvince,
        postalCode,
        country,
        phone,
        allergies,
        emergencyContactName,
        emergencyContactPhone,
        relationshipTag,
        avatarPath,
        createdAt,
        updatedAt,
        deletedAt,
        synchronized,
      ];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;

  static const String $name = 'profiles';

  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('address_line1')) {
      context.handle(
          _addressLine1Meta,
          addressLine1.isAcceptableOrUnknown(
              data['address_line1']!, _addressLine1Meta));
    }
    if (data.containsKey('address_line2')) {
      context.handle(
          _addressLine2Meta,
          addressLine2.isAcceptableOrUnknown(
              data['address_line2']!, _addressLine2Meta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('state_province')) {
      context.handle(
          _stateProvinceMeta,
          stateProvince.isAcceptableOrUnknown(
              data['state_province']!, _stateProvinceMeta));
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('allergies')) {
      context.handle(_allergiesMeta,
          allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta));
    }
    if (data.containsKey('emergency_contact_name')) {
      context.handle(
          _emergencyContactNameMeta,
          emergencyContactName.isAcceptableOrUnknown(
              data['emergency_contact_name']!, _emergencyContactNameMeta));
    }
    if (data.containsKey('emergency_contact_phone')) {
      context.handle(
          _emergencyContactPhoneMeta,
          emergencyContactPhone.isAcceptableOrUnknown(
              data['emergency_contact_phone']!, _emergencyContactPhoneMeta));
    }
    context.handle(_relationshipTagMeta, const VerificationResult.success());
    if (data.containsKey('avatar_path')) {
      context.handle(
          _avatarPathMeta,
          avatarPath.isAcceptableOrUnknown(
              data['avatar_path']!, _avatarPathMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _createdAtMeta,
          createdAt.isAcceptableOrUnknown(
              data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
          _updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(
              data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
          _deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(
              data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synchronized')) {
      context.handle(
          _synchronizedMeta,
          synchronized.isAcceptableOrUnknown(
              data['synchronized']!, _synchronizedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_of_birth']),
      addressLine1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_line1']),
      addressLine2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_line2']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      stateProvince: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state_province']),
      postalCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postal_code']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      allergies: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}allergies']),
      emergencyContactName: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}emergency_contact_name']),
      emergencyContactPhone: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}emergency_contact_phone']),
      relationshipTag: $ProfilesTable.$converterrelationshipTag.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}relationship_tag'])!),
      avatarPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_path']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synchronized: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synchronized'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class CustomField extends DataClass implements Insertable<CustomField> {
  final String id;
  final String profileId;
  final String label;
  final CustomFieldType fieldType;
  final String? value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synchronized;

  const CustomField({
    required this.id,
    required this.profileId,
    required this.label,
    required this.fieldType,
    this.value,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.synchronized,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['label'] = Variable<String>(label);
    {
      final converter = $CustomFieldsTable.$converterfieldType;
      map['field_type'] = Variable<String>(converter.toSql(fieldType));
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synchronized'] = Variable<bool>(synchronized);
    return map;
  }

  CustomFieldsCompanion toCompanion(bool nullToAbsent) {
    return CustomFieldsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      label: Value(label),
      fieldType: Value(fieldType),
      value: value == null && nullToAbsent ? const Value.absent() : Value(value),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synchronized: Value(synchronized),
    );
  }

  factory CustomField.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomField(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      label: serializer.fromJson<String>(json['label']),
      fieldType: $CustomFieldsTable.$converterfieldType
          .fromJson(serializer.fromJson<String>(json['fieldType'])),
      value: serializer.fromJson<String?>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synchronized: serializer.fromJson<bool>(json['synchronized']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'label': serializer.toJson<String>(label),
      'fieldType': serializer.toJson<String>(
          $CustomFieldsTable.$converterfieldType.toJson(fieldType)),
      'value': serializer.toJson<String?>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synchronized': serializer.toJson<bool>(synchronized),
    };
  }

  CustomField copyWith({
    String? id,
    String? profileId,
    String? label,
    CustomFieldType? fieldType,
    Value<String?> value = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    bool? synchronized,
  }) =>
      CustomField(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        label: label ?? this.label,
        fieldType: fieldType ?? this.fieldType,
        value: value.present ? value.value : this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synchronized: synchronized ?? this.synchronized,
      );

  CustomField copyWithCompanion(CustomFieldsCompanion data) {
    return CustomField(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      label: data.label.present ? data.label.value : this.label,
      fieldType: data.fieldType.present ? data.fieldType.value : this.fieldType,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synchronized: data.synchronized.present
          ? data.synchronized.value
          : this.synchronized,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomField(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('label: $label, ')
          ..write('fieldType: $fieldType, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synchronized: $synchronized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        profileId,
        label,
        fieldType,
        value,
        createdAt,
        updatedAt,
        deletedAt,
        synchronized,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomField &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.label == this.label &&
          other.fieldType == this.fieldType &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synchronized == this.synchronized);
}

class CustomFieldsCompanion extends UpdateCompanion<CustomField> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> label;
  final Value<CustomFieldType> fieldType;
  final Value<String?> value;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synchronized;
  final Value<int> rowid;

  const CustomFieldsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.label = const Value.absent(),
    this.fieldType = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synchronized = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  CustomFieldsCompanion.insert({
    required String id,
    required String profileId,
    required String label,
    required CustomFieldType fieldType,
    Value<String?> value = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<bool> synchronized = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        profileId = Value(profileId),
        label = Value(label),
        fieldType = Value(fieldType),
        value = value,
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        deletedAt = deletedAt,
        synchronized = synchronized;

  static Insertable<CustomField> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? label,
    Expression<String>? fieldType,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synchronized,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (label != null) 'label': label,
      if (fieldType != null) 'field_type': fieldType,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synchronized != null) 'synchronized': synchronized,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomFieldsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? label,
    Value<CustomFieldType>? fieldType,
    Value<String?>? value,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<bool>? synchronized,
    Value<int>? rowid,
  }) {
    return CustomFieldsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      label: label ?? this.label,
      fieldType: fieldType ?? this.fieldType,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synchronized: synchronized ?? this.synchronized,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (fieldType.present) {
      final converter = $CustomFieldsTable.$converterfieldType;
      map['field_type'] =
          Variable<String>(converter.toSql(fieldType.value));
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synchronized.present) {
      map['synchronized'] = Variable<bool>(synchronized.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomFieldsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('label: $label, ')
          ..write('fieldType: $fieldType, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synchronized: $synchronized, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomFieldsTable extends CustomFields
    with TableInfo<$CustomFieldsTable, CustomField> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $CustomFieldsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);

  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES profiles(id)');

  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  static const VerificationMeta _fieldTypeMeta =
      const VerificationMeta('fieldType');
  @override
  late final GeneratedColumnWithTypeConverter<CustomFieldType, String>
      fieldType = GeneratedColumnWithTypeConverter<CustomFieldType, String>(
          'field_type', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          converter: $CustomFieldsTable.$converterfieldType);

  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);

  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);

  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);

  static const VerificationMeta _synchronizedMeta =
      const VerificationMeta('synchronized');
  @override
  late final GeneratedColumn<bool> synchronized = GeneratedColumn<bool>(
      'synchronized', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultValue: const Constant(false));

  static JsonTypeConverter2<CustomFieldType, String, String>
      $converterfieldType =
      const EnumNameConverter<CustomFieldType>(CustomFieldType.values);

  @override
  List<GeneratedColumn> get $columns => [
        id,
        profileId,
        label,
        fieldType,
        value,
        createdAt,
        updatedAt,
        deletedAt,
        synchronized,
      ];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;

  static const String $name = 'custom_fields';

  @override
  VerificationContext validateIntegrity(Insertable<CustomField> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
          _profileIdMeta,
          profileId.isAcceptableOrUnknown(
              data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(_labelMeta,
          label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    context.handle(_fieldTypeMeta, const VerificationResult.success());
    if (data.containsKey('value')) {
      context.handle(_valueMeta,
          value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
          _createdAtMeta,
          createdAt.isAcceptableOrUnknown(
              data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
          _updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(
              data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
          _deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(
              data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synchronized')) {
      context.handle(
          _synchronizedMeta,
          synchronized.isAcceptableOrUnknown(
              data['synchronized']!, _synchronizedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  CustomField map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomField(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      fieldType: $CustomFieldsTable.$converterfieldType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}field_type'])!),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synchronized: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synchronized'])!,
    );
  }

  @override
  $CustomFieldsTable createAlias(String alias) {
    return $CustomFieldsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $CustomFieldsTable customFields = $CustomFieldsTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [profiles, customFields];
}
