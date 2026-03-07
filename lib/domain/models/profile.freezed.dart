// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// **************************************************************************
// NOTE: This file was hand-authored because build_runner cannot run in the
// current environment (Flutter/Dart SDK not installed). When Flutter SDK is
// available, regenerate by running:
//   flutter pub run build_runner build --delete-conflicting-outputs
// **************************************************************************

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FamilyProfile {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get addressLine1 => throw _privateConstructorUsedError;
  String? get addressLine2 => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get stateProvince => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get allergies => throw _privateConstructorUsedError;
  String? get emergencyContactName => throw _privateConstructorUsedError;
  String? get emergencyContactPhone => throw _privateConstructorUsedError;
  RelationshipTag get relationshipTag => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool get synchronized => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FamilyProfileCopyWith<FamilyProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FamilyProfileCopyWith<$Res> {
  factory $FamilyProfileCopyWith(
          FamilyProfile value, $Res Function(FamilyProfile) then) =
      _$FamilyProfileCopyWithImpl<$Res, FamilyProfile>;
  @useResult
  $Res call({
    String id,
    String displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag relationshipTag,
    String? avatarPath,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? deletedAt,
    bool synchronized,
  });
}

/// @nodoc
class _$FamilyProfileCopyWithImpl<$Res, $Val extends FamilyProfile>
    implements $FamilyProfileCopyWith<$Res> {
  _$FamilyProfileCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = null,
    Object? avatarPath = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? synchronized = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth as String?,
      addressLine1: freezed == addressLine1
          ? _value.addressLine1
          : addressLine1 as String?,
      addressLine2: freezed == addressLine2
          ? _value.addressLine2
          : addressLine2 as String?,
      city: freezed == city
          ? _value.city
          : city as String?,
      stateProvince: freezed == stateProvince
          ? _value.stateProvince
          : stateProvince as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode as String?,
      country: freezed == country
          ? _value.country
          : country as String?,
      phone: freezed == phone
          ? _value.phone
          : phone as String?,
      allergies: freezed == allergies
          ? _value.allergies
          : allergies as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone as String?,
      relationshipTag: null == relationshipTag
          ? _value.relationshipTag
          : relationshipTag as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _value.avatarPath
          : avatarPath as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt as DateTime?,
      synchronized: null == synchronized
          ? _value.synchronized
          : synchronized as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FamilyProfileImplCopyWith<$Res>
    implements $FamilyProfileCopyWith<$Res> {
  factory _$$FamilyProfileImplCopyWith(
          _$FamilyProfileImpl value, $Res Function(_$FamilyProfileImpl) then) =
      __$$FamilyProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag relationshipTag,
    String? avatarPath,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? deletedAt,
    bool synchronized,
  });
}

/// @nodoc
class __$$FamilyProfileImplCopyWithImpl<$Res>
    extends _$FamilyProfileCopyWithImpl<$Res, _$FamilyProfileImpl>
    implements _$$FamilyProfileImplCopyWith<$Res> {
  __$$FamilyProfileImplCopyWithImpl(
      _$FamilyProfileImpl _value, $Res Function(_$FamilyProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = null,
    Object? avatarPath = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? synchronized = null,
  }) {
    return _then(_$FamilyProfileImpl(
      id: null == id
          ? _value.id
          : id as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName as String,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth as String?,
      addressLine1: freezed == addressLine1
          ? _value.addressLine1
          : addressLine1 as String?,
      addressLine2: freezed == addressLine2
          ? _value.addressLine2
          : addressLine2 as String?,
      city: freezed == city
          ? _value.city
          : city as String?,
      stateProvince: freezed == stateProvince
          ? _value.stateProvince
          : stateProvince as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode as String?,
      country: freezed == country
          ? _value.country
          : country as String?,
      phone: freezed == phone
          ? _value.phone
          : phone as String?,
      allergies: freezed == allergies
          ? _value.allergies
          : allergies as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _value.emergencyContactName
          : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _value.emergencyContactPhone
          : emergencyContactPhone as String?,
      relationshipTag: null == relationshipTag
          ? _value.relationshipTag
          : relationshipTag as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _value.avatarPath
          : avatarPath as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt as DateTime?,
      synchronized: null == synchronized
          ? _value.synchronized
          : synchronized as bool,
    ));
  }
}

/// @nodoc

class _$FamilyProfileImpl implements _FamilyProfile {
  const _$FamilyProfileImpl({
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
  final String id;
  @override
  final String displayName;
  @override
  final String? dateOfBirth;
  @override
  final String? addressLine1;
  @override
  final String? addressLine2;
  @override
  final String? city;
  @override
  final String? stateProvince;
  @override
  final String? postalCode;
  @override
  final String? country;
  @override
  final String? phone;
  @override
  final String? allergies;
  @override
  final String? emergencyContactName;
  @override
  final String? emergencyContactPhone;
  @override
  final RelationshipTag relationshipTag;
  @override
  final String? avatarPath;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final bool synchronized;

  @override
  String toString() {
    return 'FamilyProfile(id: $id, displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FamilyProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.addressLine1, addressLine1) ||
                other.addressLine1 == addressLine1) &&
            (identical(other.addressLine2, addressLine2) ||
                other.addressLine2 == addressLine2) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.stateProvince, stateProvince) ||
                other.stateProvince == stateProvince) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.allergies, allergies) ||
                other.allergies == allergies) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactPhone, emergencyContactPhone) ||
                other.emergencyContactPhone == emergencyContactPhone) &&
            (identical(other.relationshipTag, relationshipTag) ||
                other.relationshipTag == relationshipTag) &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.synchronized, synchronized) ||
                other.synchronized == synchronized));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      synchronized);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FamilyProfileImplCopyWith<_$FamilyProfileImpl> get copyWith =>
      __$$FamilyProfileImplCopyWithImpl<_$FamilyProfileImpl>(this, _$identity);
}

abstract class _FamilyProfile implements FamilyProfile {
  const factory _FamilyProfile({
    required final String id,
    required final String displayName,
    final String? dateOfBirth,
    final String? addressLine1,
    final String? addressLine2,
    final String? city,
    final String? stateProvince,
    final String? postalCode,
    final String? country,
    final String? phone,
    final String? allergies,
    final String? emergencyContactName,
    final String? emergencyContactPhone,
    required final RelationshipTag relationshipTag,
    final String? avatarPath,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? deletedAt,
    required final bool synchronized,
  }) = _$FamilyProfileImpl;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String? get dateOfBirth;
  @override
  String? get addressLine1;
  @override
  String? get addressLine2;
  @override
  String? get city;
  @override
  String? get stateProvince;
  @override
  String? get postalCode;
  @override
  String? get country;
  @override
  String? get phone;
  @override
  String? get allergies;
  @override
  String? get emergencyContactName;
  @override
  String? get emergencyContactPhone;
  @override
  RelationshipTag get relationshipTag;
  @override
  String? get avatarPath;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  bool get synchronized;
  @override
  @JsonKey(ignore: true)
  _$$FamilyProfileImplCopyWith<_$FamilyProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// ---- ProfileCreateRequest ----

/// @nodoc
mixin _$ProfileCreateRequest {
  String get displayName => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get addressLine1 => throw _privateConstructorUsedError;
  String? get addressLine2 => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get stateProvince => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get allergies => throw _privateConstructorUsedError;
  String? get emergencyContactName => throw _privateConstructorUsedError;
  String? get emergencyContactPhone => throw _privateConstructorUsedError;
  RelationshipTag get relationshipTag => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileCreateRequestCopyWith<ProfileCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCreateRequestCopyWith<$Res> {
  factory $ProfileCreateRequestCopyWith(ProfileCreateRequest value,
          $Res Function(ProfileCreateRequest) then) =
      _$ProfileCreateRequestCopyWithImpl<$Res, ProfileCreateRequest>;
  @useResult
  $Res call({
    String displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag relationshipTag,
    String? avatarPath,
  });
}

/// @nodoc
class _$ProfileCreateRequestCopyWithImpl<$Res,
        $Val extends ProfileCreateRequest>
    implements $ProfileCreateRequestCopyWith<$Res> {
  _$ProfileCreateRequestCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = null,
    Object? avatarPath = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName ? _value.displayName : displayName as String,
      dateOfBirth: freezed == dateOfBirth ? _value.dateOfBirth : dateOfBirth as String?,
      addressLine1: freezed == addressLine1 ? _value.addressLine1 : addressLine1 as String?,
      addressLine2: freezed == addressLine2 ? _value.addressLine2 : addressLine2 as String?,
      city: freezed == city ? _value.city : city as String?,
      stateProvince: freezed == stateProvince ? _value.stateProvince : stateProvince as String?,
      postalCode: freezed == postalCode ? _value.postalCode : postalCode as String?,
      country: freezed == country ? _value.country : country as String?,
      phone: freezed == phone ? _value.phone : phone as String?,
      allergies: freezed == allergies ? _value.allergies : allergies as String?,
      emergencyContactName: freezed == emergencyContactName ? _value.emergencyContactName : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone ? _value.emergencyContactPhone : emergencyContactPhone as String?,
      relationshipTag: null == relationshipTag ? _value.relationshipTag : relationshipTag as RelationshipTag,
      avatarPath: freezed == avatarPath ? _value.avatarPath : avatarPath as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileCreateRequestImplCopyWith<$Res>
    implements $ProfileCreateRequestCopyWith<$Res> {
  factory _$$ProfileCreateRequestImplCopyWith(_$ProfileCreateRequestImpl value,
          $Res Function(_$ProfileCreateRequestImpl) then) =
      __$$ProfileCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag relationshipTag,
    String? avatarPath,
  });
}

/// @nodoc
class __$$ProfileCreateRequestImplCopyWithImpl<$Res>
    extends _$ProfileCreateRequestCopyWithImpl<$Res, _$ProfileCreateRequestImpl>
    implements _$$ProfileCreateRequestImplCopyWith<$Res> {
  __$$ProfileCreateRequestImplCopyWithImpl(_$ProfileCreateRequestImpl _value,
      $Res Function(_$ProfileCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = null,
    Object? avatarPath = freezed,
  }) {
    return _then(_$ProfileCreateRequestImpl(
      displayName: null == displayName ? _value.displayName : displayName as String,
      dateOfBirth: freezed == dateOfBirth ? _value.dateOfBirth : dateOfBirth as String?,
      addressLine1: freezed == addressLine1 ? _value.addressLine1 : addressLine1 as String?,
      addressLine2: freezed == addressLine2 ? _value.addressLine2 : addressLine2 as String?,
      city: freezed == city ? _value.city : city as String?,
      stateProvince: freezed == stateProvince ? _value.stateProvince : stateProvince as String?,
      postalCode: freezed == postalCode ? _value.postalCode : postalCode as String?,
      country: freezed == country ? _value.country : country as String?,
      phone: freezed == phone ? _value.phone : phone as String?,
      allergies: freezed == allergies ? _value.allergies : allergies as String?,
      emergencyContactName: freezed == emergencyContactName ? _value.emergencyContactName : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone ? _value.emergencyContactPhone : emergencyContactPhone as String?,
      relationshipTag: null == relationshipTag ? _value.relationshipTag : relationshipTag as RelationshipTag,
      avatarPath: freezed == avatarPath ? _value.avatarPath : avatarPath as String?,
    ));
  }
}

/// @nodoc
class _$ProfileCreateRequestImpl implements _ProfileCreateRequest {
  const _$ProfileCreateRequestImpl({
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
  });

  @override
  final String displayName;
  @override
  final String? dateOfBirth;
  @override
  final String? addressLine1;
  @override
  final String? addressLine2;
  @override
  final String? city;
  @override
  final String? stateProvince;
  @override
  final String? postalCode;
  @override
  final String? country;
  @override
  final String? phone;
  @override
  final String? allergies;
  @override
  final String? emergencyContactName;
  @override
  final String? emergencyContactPhone;
  @override
  final RelationshipTag relationshipTag;
  @override
  final String? avatarPath;

  @override
  String toString() {
    return 'ProfileCreateRequest(displayName: $displayName, relationshipTag: $relationshipTag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileCreateRequestImpl &&
            other.displayName == displayName &&
            other.relationshipTag == relationshipTag);
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayName, relationshipTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileCreateRequestImplCopyWith<_$ProfileCreateRequestImpl>
      get copyWith =>
          __$$ProfileCreateRequestImplCopyWithImpl<_$ProfileCreateRequestImpl>(
              this, _$identity);
}

abstract class _ProfileCreateRequest implements ProfileCreateRequest {
  const factory _ProfileCreateRequest({
    required final String displayName,
    final String? dateOfBirth,
    final String? addressLine1,
    final String? addressLine2,
    final String? city,
    final String? stateProvince,
    final String? postalCode,
    final String? country,
    final String? phone,
    final String? allergies,
    final String? emergencyContactName,
    final String? emergencyContactPhone,
    required final RelationshipTag relationshipTag,
    final String? avatarPath,
  }) = _$ProfileCreateRequestImpl;

  @override
  String get displayName;
  @override
  String? get dateOfBirth;
  @override
  String? get addressLine1;
  @override
  String? get addressLine2;
  @override
  String? get city;
  @override
  String? get stateProvince;
  @override
  String? get postalCode;
  @override
  String? get country;
  @override
  String? get phone;
  @override
  String? get allergies;
  @override
  String? get emergencyContactName;
  @override
  String? get emergencyContactPhone;
  @override
  RelationshipTag get relationshipTag;
  @override
  String? get avatarPath;
  @override
  @JsonKey(ignore: true)
  _$$ProfileCreateRequestImplCopyWith<_$ProfileCreateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// ---- ProfileUpdateRequest ----

/// @nodoc
mixin _$ProfileUpdateRequest {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get addressLine1 => throw _privateConstructorUsedError;
  String? get addressLine2 => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get stateProvince => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get allergies => throw _privateConstructorUsedError;
  String? get emergencyContactName => throw _privateConstructorUsedError;
  String? get emergencyContactPhone => throw _privateConstructorUsedError;
  RelationshipTag? get relationshipTag => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileUpdateRequestCopyWith<ProfileUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateRequestCopyWith<$Res> {
  factory $ProfileUpdateRequestCopyWith(ProfileUpdateRequest value,
          $Res Function(ProfileUpdateRequest) then) =
      _$ProfileUpdateRequestCopyWithImpl<$Res, ProfileUpdateRequest>;
  @useResult
  $Res call({
    String id,
    String? displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag? relationshipTag,
    String? avatarPath,
  });
}

/// @nodoc
class _$ProfileUpdateRequestCopyWithImpl<$Res,
        $Val extends ProfileUpdateRequest>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  _$ProfileUpdateRequestCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = freezed,
    Object? avatarPath = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as String,
      displayName: freezed == displayName ? _value.displayName : displayName as String?,
      dateOfBirth: freezed == dateOfBirth ? _value.dateOfBirth : dateOfBirth as String?,
      addressLine1: freezed == addressLine1 ? _value.addressLine1 : addressLine1 as String?,
      addressLine2: freezed == addressLine2 ? _value.addressLine2 : addressLine2 as String?,
      city: freezed == city ? _value.city : city as String?,
      stateProvince: freezed == stateProvince ? _value.stateProvince : stateProvince as String?,
      postalCode: freezed == postalCode ? _value.postalCode : postalCode as String?,
      country: freezed == country ? _value.country : country as String?,
      phone: freezed == phone ? _value.phone : phone as String?,
      allergies: freezed == allergies ? _value.allergies : allergies as String?,
      emergencyContactName: freezed == emergencyContactName ? _value.emergencyContactName : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone ? _value.emergencyContactPhone : emergencyContactPhone as String?,
      relationshipTag: freezed == relationshipTag ? _value.relationshipTag : relationshipTag as RelationshipTag?,
      avatarPath: freezed == avatarPath ? _value.avatarPath : avatarPath as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileUpdateRequestImplCopyWith<$Res>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  factory _$$ProfileUpdateRequestImplCopyWith(_$ProfileUpdateRequestImpl value,
          $Res Function(_$ProfileUpdateRequestImpl) then) =
      __$$ProfileUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? displayName,
    String? dateOfBirth,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    String? phone,
    String? allergies,
    String? emergencyContactName,
    String? emergencyContactPhone,
    RelationshipTag? relationshipTag,
    String? avatarPath,
  });
}

/// @nodoc
class __$$ProfileUpdateRequestImplCopyWithImpl<$Res>
    extends _$ProfileUpdateRequestCopyWithImpl<$Res, _$ProfileUpdateRequestImpl>
    implements _$$ProfileUpdateRequestImplCopyWith<$Res> {
  __$$ProfileUpdateRequestImplCopyWithImpl(_$ProfileUpdateRequestImpl _value,
      $Res Function(_$ProfileUpdateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? dateOfBirth = freezed,
    Object? addressLine1 = freezed,
    Object? addressLine2 = freezed,
    Object? city = freezed,
    Object? stateProvince = freezed,
    Object? postalCode = freezed,
    Object? country = freezed,
    Object? phone = freezed,
    Object? allergies = freezed,
    Object? emergencyContactName = freezed,
    Object? emergencyContactPhone = freezed,
    Object? relationshipTag = freezed,
    Object? avatarPath = freezed,
  }) {
    return _then(_$ProfileUpdateRequestImpl(
      id: null == id ? _value.id : id as String,
      displayName: freezed == displayName ? _value.displayName : displayName as String?,
      dateOfBirth: freezed == dateOfBirth ? _value.dateOfBirth : dateOfBirth as String?,
      addressLine1: freezed == addressLine1 ? _value.addressLine1 : addressLine1 as String?,
      addressLine2: freezed == addressLine2 ? _value.addressLine2 : addressLine2 as String?,
      city: freezed == city ? _value.city : city as String?,
      stateProvince: freezed == stateProvince ? _value.stateProvince : stateProvince as String?,
      postalCode: freezed == postalCode ? _value.postalCode : postalCode as String?,
      country: freezed == country ? _value.country : country as String?,
      phone: freezed == phone ? _value.phone : phone as String?,
      allergies: freezed == allergies ? _value.allergies : allergies as String?,
      emergencyContactName: freezed == emergencyContactName ? _value.emergencyContactName : emergencyContactName as String?,
      emergencyContactPhone: freezed == emergencyContactPhone ? _value.emergencyContactPhone : emergencyContactPhone as String?,
      relationshipTag: freezed == relationshipTag ? _value.relationshipTag : relationshipTag as RelationshipTag?,
      avatarPath: freezed == avatarPath ? _value.avatarPath : avatarPath as String?,
    ));
  }
}

/// @nodoc
class _$ProfileUpdateRequestImpl implements _ProfileUpdateRequest {
  const _$ProfileUpdateRequestImpl({
    required this.id,
    this.displayName,
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
    this.relationshipTag,
    this.avatarPath,
  });

  @override
  final String id;
  @override
  final String? displayName;
  @override
  final String? dateOfBirth;
  @override
  final String? addressLine1;
  @override
  final String? addressLine2;
  @override
  final String? city;
  @override
  final String? stateProvince;
  @override
  final String? postalCode;
  @override
  final String? country;
  @override
  final String? phone;
  @override
  final String? allergies;
  @override
  final String? emergencyContactName;
  @override
  final String? emergencyContactPhone;
  @override
  final RelationshipTag? relationshipTag;
  @override
  final String? avatarPath;

  @override
  String toString() => 'ProfileUpdateRequest(id: $id)';

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateRequestImpl &&
            other.id == id);
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateRequestImplCopyWith<_$ProfileUpdateRequestImpl>
      get copyWith =>
          __$$ProfileUpdateRequestImplCopyWithImpl<_$ProfileUpdateRequestImpl>(
              this, _$identity);
}

abstract class _ProfileUpdateRequest implements ProfileUpdateRequest {
  const factory _ProfileUpdateRequest({
    required final String id,
    final String? displayName,
    final String? dateOfBirth,
    final String? addressLine1,
    final String? addressLine2,
    final String? city,
    final String? stateProvince,
    final String? postalCode,
    final String? country,
    final String? phone,
    final String? allergies,
    final String? emergencyContactName,
    final String? emergencyContactPhone,
    final RelationshipTag? relationshipTag,
    final String? avatarPath,
  }) = _$ProfileUpdateRequestImpl;

  @override
  String get id;
  @override
  String? get displayName;
  @override
  String? get dateOfBirth;
  @override
  String? get addressLine1;
  @override
  String? get addressLine2;
  @override
  String? get city;
  @override
  String? get stateProvince;
  @override
  String? get postalCode;
  @override
  String? get country;
  @override
  String? get phone;
  @override
  String? get allergies;
  @override
  String? get emergencyContactName;
  @override
  String? get emergencyContactPhone;
  @override
  RelationshipTag? get relationshipTag;
  @override
  String? get avatarPath;
  @override
  @JsonKey(ignore: true)
  _$$ProfileUpdateRequestImplCopyWith<_$ProfileUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
