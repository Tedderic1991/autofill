// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyProfile {
  String get id;
  String get displayName;
  String? get dateOfBirth;
  String? get addressLine1;
  String? get addressLine2;
  String? get city;
  String? get stateProvince;
  String? get postalCode;
  String? get country;
  String? get phone;
  String? get allergies;
  String? get emergencyContactName;
  String? get emergencyContactPhone;
  RelationshipTag get relationshipTag;
  String? get avatarPath;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  bool get synchronized;

  /// Create a copy of FamilyProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FamilyProfileCopyWith<FamilyProfile> get copyWith =>
      _$FamilyProfileCopyWithImpl<FamilyProfile>(
          this as FamilyProfile, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FamilyProfile &&
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
  int get hashCode => Object.hashAll([
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
        synchronized
      ]);

  @override
  String toString() {
    return 'FamilyProfile(id: $id, displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }
}

/// @nodoc
abstract mixin class $FamilyProfileCopyWith<$Res> {
  factory $FamilyProfileCopyWith(
          FamilyProfile value, $Res Function(FamilyProfile) _then) =
      _$FamilyProfileCopyWithImpl;
  @useResult
  $Res call(
      {String id,
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
      bool synchronized});
}

/// @nodoc
class _$FamilyProfileCopyWithImpl<$Res>
    implements $FamilyProfileCopyWith<$Res> {
  _$FamilyProfileCopyWithImpl(this._self, this._then);

  final FamilyProfile _self;
  final $Res Function(FamilyProfile) _then;

  /// Create a copy of FamilyProfile
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: null == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      synchronized: null == synchronized
          ? _self.synchronized
          : synchronized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FamilyProfile].
extension FamilyProfilePatterns on FamilyProfile {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_FamilyProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_FamilyProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_FamilyProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
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
            bool synchronized)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.synchronized);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
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
            bool synchronized)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile():
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.synchronized);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
            bool synchronized)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FamilyProfile() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.synchronized);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FamilyProfile implements FamilyProfile {
  const _FamilyProfile(
      {required this.id,
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
      required this.synchronized});

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

  /// Create a copy of FamilyProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FamilyProfileCopyWith<_FamilyProfile> get copyWith =>
      __$FamilyProfileCopyWithImpl<_FamilyProfile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FamilyProfile &&
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
  int get hashCode => Object.hashAll([
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
        synchronized
      ]);

  @override
  String toString() {
    return 'FamilyProfile(id: $id, displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }
}

/// @nodoc
abstract mixin class _$FamilyProfileCopyWith<$Res>
    implements $FamilyProfileCopyWith<$Res> {
  factory _$FamilyProfileCopyWith(
          _FamilyProfile value, $Res Function(_FamilyProfile) _then) =
      __$FamilyProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
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
      bool synchronized});
}

/// @nodoc
class __$FamilyProfileCopyWithImpl<$Res>
    implements _$FamilyProfileCopyWith<$Res> {
  __$FamilyProfileCopyWithImpl(this._self, this._then);

  final _FamilyProfile _self;
  final $Res Function(_FamilyProfile) _then;

  /// Create a copy of FamilyProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_FamilyProfile(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: null == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      synchronized: null == synchronized
          ? _self.synchronized
          : synchronized // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ProfileCreateRequest {
  String get displayName;
  String? get dateOfBirth;
  String? get addressLine1;
  String? get addressLine2;
  String? get city;
  String? get stateProvince;
  String? get postalCode;
  String? get country;
  String? get phone;
  String? get allergies;
  String? get emergencyContactName;
  String? get emergencyContactPhone;
  RelationshipTag get relationshipTag;
  String? get avatarPath;

  /// Create a copy of ProfileCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileCreateRequestCopyWith<ProfileCreateRequest> get copyWith =>
      _$ProfileCreateRequestCopyWithImpl<ProfileCreateRequest>(
          this as ProfileCreateRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileCreateRequest &&
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
                other.avatarPath == avatarPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      avatarPath);

  @override
  String toString() {
    return 'ProfileCreateRequest(displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath)';
  }
}

/// @nodoc
abstract mixin class $ProfileCreateRequestCopyWith<$Res> {
  factory $ProfileCreateRequestCopyWith(ProfileCreateRequest value,
          $Res Function(ProfileCreateRequest) _then) =
      _$ProfileCreateRequestCopyWithImpl;
  @useResult
  $Res call(
      {String displayName,
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
      String? avatarPath});
}

/// @nodoc
class _$ProfileCreateRequestCopyWithImpl<$Res>
    implements $ProfileCreateRequestCopyWith<$Res> {
  _$ProfileCreateRequestCopyWithImpl(this._self, this._then);

  final ProfileCreateRequest _self;
  final $Res Function(ProfileCreateRequest) _then;

  /// Create a copy of ProfileCreateRequest
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: null == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProfileCreateRequest].
extension ProfileCreateRequestPatterns on ProfileCreateRequest {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ProfileCreateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ProfileCreateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ProfileCreateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
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
            String? avatarPath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest() when $default != null:
        return $default(
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
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
            String? avatarPath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest():
        return $default(
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
            String? avatarPath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileCreateRequest() when $default != null:
        return $default(
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProfileCreateRequest implements ProfileCreateRequest {
  const _ProfileCreateRequest(
      {required this.displayName,
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
      this.avatarPath});

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

  /// Create a copy of ProfileCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileCreateRequestCopyWith<_ProfileCreateRequest> get copyWith =>
      __$ProfileCreateRequestCopyWithImpl<_ProfileCreateRequest>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileCreateRequest &&
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
                other.avatarPath == avatarPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
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
      avatarPath);

  @override
  String toString() {
    return 'ProfileCreateRequest(displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath)';
  }
}

/// @nodoc
abstract mixin class _$ProfileCreateRequestCopyWith<$Res>
    implements $ProfileCreateRequestCopyWith<$Res> {
  factory _$ProfileCreateRequestCopyWith(_ProfileCreateRequest value,
          $Res Function(_ProfileCreateRequest) _then) =
      __$ProfileCreateRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String displayName,
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
      String? avatarPath});
}

/// @nodoc
class __$ProfileCreateRequestCopyWithImpl<$Res>
    implements _$ProfileCreateRequestCopyWith<$Res> {
  __$ProfileCreateRequestCopyWithImpl(this._self, this._then);

  final _ProfileCreateRequest _self;
  final $Res Function(_ProfileCreateRequest) _then;

  /// Create a copy of ProfileCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ProfileCreateRequest(
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: null == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$ProfileUpdateRequest {
  String get id;
  String? get displayName;
  String? get dateOfBirth;
  String? get addressLine1;
  String? get addressLine2;
  String? get city;
  String? get stateProvince;
  String? get postalCode;
  String? get country;
  String? get phone;
  String? get allergies;
  String? get emergencyContactName;
  String? get emergencyContactPhone;
  RelationshipTag? get relationshipTag;
  String? get avatarPath;

  /// Create a copy of ProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileUpdateRequestCopyWith<ProfileUpdateRequest> get copyWith =>
      _$ProfileUpdateRequestCopyWithImpl<ProfileUpdateRequest>(
          this as ProfileUpdateRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileUpdateRequest &&
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
                other.avatarPath == avatarPath));
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
      avatarPath);

  @override
  String toString() {
    return 'ProfileUpdateRequest(id: $id, displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath)';
  }
}

/// @nodoc
abstract mixin class $ProfileUpdateRequestCopyWith<$Res> {
  factory $ProfileUpdateRequestCopyWith(ProfileUpdateRequest value,
          $Res Function(ProfileUpdateRequest) _then) =
      _$ProfileUpdateRequestCopyWithImpl;
  @useResult
  $Res call(
      {String id,
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
      String? avatarPath});
}

/// @nodoc
class _$ProfileUpdateRequestCopyWithImpl<$Res>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  _$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final ProfileUpdateRequest _self;
  final $Res Function(ProfileUpdateRequest) _then;

  /// Create a copy of ProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: freezed == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag?,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ProfileUpdateRequest].
extension ProfileUpdateRequestPatterns on ProfileUpdateRequest {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ProfileUpdateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ProfileUpdateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ProfileUpdateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
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
            String? avatarPath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
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
            String? avatarPath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest():
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
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
            String? avatarPath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ProfileUpdateRequest() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.dateOfBirth,
            _that.addressLine1,
            _that.addressLine2,
            _that.city,
            _that.stateProvince,
            _that.postalCode,
            _that.country,
            _that.phone,
            _that.allergies,
            _that.emergencyContactName,
            _that.emergencyContactPhone,
            _that.relationshipTag,
            _that.avatarPath);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ProfileUpdateRequest implements ProfileUpdateRequest {
  const _ProfileUpdateRequest(
      {required this.id,
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
      this.avatarPath});

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

  /// Create a copy of ProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileUpdateRequestCopyWith<_ProfileUpdateRequest> get copyWith =>
      __$ProfileUpdateRequestCopyWithImpl<_ProfileUpdateRequest>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileUpdateRequest &&
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
                other.avatarPath == avatarPath));
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
      avatarPath);

  @override
  String toString() {
    return 'ProfileUpdateRequest(id: $id, displayName: $displayName, dateOfBirth: $dateOfBirth, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, stateProvince: $stateProvince, postalCode: $postalCode, country: $country, phone: $phone, allergies: $allergies, emergencyContactName: $emergencyContactName, emergencyContactPhone: $emergencyContactPhone, relationshipTag: $relationshipTag, avatarPath: $avatarPath)';
  }
}

/// @nodoc
abstract mixin class _$ProfileUpdateRequestCopyWith<$Res>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  factory _$ProfileUpdateRequestCopyWith(_ProfileUpdateRequest value,
          $Res Function(_ProfileUpdateRequest) _then) =
      __$ProfileUpdateRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
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
      String? avatarPath});
}

/// @nodoc
class __$ProfileUpdateRequestCopyWithImpl<$Res>
    implements _$ProfileUpdateRequestCopyWith<$Res> {
  __$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final _ProfileUpdateRequest _self;
  final $Res Function(_ProfileUpdateRequest) _then;

  /// Create a copy of ProfileUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_ProfileUpdateRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _self.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine1: freezed == addressLine1
          ? _self.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      addressLine2: freezed == addressLine2
          ? _self.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProvince: freezed == stateProvince
          ? _self.stateProvince
          : stateProvince // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _self.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: freezed == allergies
          ? _self.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactName: freezed == emergencyContactName
          ? _self.emergencyContactName
          : emergencyContactName // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContactPhone: freezed == emergencyContactPhone
          ? _self.emergencyContactPhone
          : emergencyContactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipTag: freezed == relationshipTag
          ? _self.relationshipTag
          : relationshipTag // ignore: cast_nullable_to_non_nullable
              as RelationshipTag?,
      avatarPath: freezed == avatarPath
          ? _self.avatarPath
          : avatarPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
