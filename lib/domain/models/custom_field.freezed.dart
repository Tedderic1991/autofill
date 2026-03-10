// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomField {
  String get id;
  String get profileId;
  String get label;
  CustomFieldType get fieldType;
  String? get value;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  bool get synchronized;

  /// Create a copy of CustomField
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomFieldCopyWith<CustomField> get copyWith =>
      _$CustomFieldCopyWithImpl<CustomField>(this as CustomField, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomField &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            (identical(other.value, value) || other.value == value) &&
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
  int get hashCode => Object.hash(runtimeType, id, profileId, label, fieldType,
      value, createdAt, updatedAt, deletedAt, synchronized);

  @override
  String toString() {
    return 'CustomField(id: $id, profileId: $profileId, label: $label, fieldType: $fieldType, value: $value, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }
}

/// @nodoc
abstract mixin class $CustomFieldCopyWith<$Res> {
  factory $CustomFieldCopyWith(
          CustomField value, $Res Function(CustomField) _then) =
      _$CustomFieldCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String profileId,
      String label,
      CustomFieldType fieldType,
      String? value,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      bool synchronized});
}

/// @nodoc
class _$CustomFieldCopyWithImpl<$Res> implements $CustomFieldCopyWith<$Res> {
  _$CustomFieldCopyWithImpl(this._self, this._then);

  final CustomField _self;
  final $Res Function(CustomField) _then;

  /// Create a copy of CustomField
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? label = null,
    Object? fieldType = null,
    Object? value = freezed,
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
      profileId: null == profileId
          ? _self.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      fieldType: null == fieldType
          ? _self.fieldType
          : fieldType // ignore: cast_nullable_to_non_nullable
              as CustomFieldType,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [CustomField].
extension CustomFieldPatterns on CustomField {
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
    TResult Function(_CustomField value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomField() when $default != null:
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
    TResult Function(_CustomField value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomField():
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
    TResult? Function(_CustomField value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomField() when $default != null:
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
            String profileId,
            String label,
            CustomFieldType fieldType,
            String? value,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            bool synchronized)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CustomField() when $default != null:
        return $default(
            _that.id,
            _that.profileId,
            _that.label,
            _that.fieldType,
            _that.value,
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
            String profileId,
            String label,
            CustomFieldType fieldType,
            String? value,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            bool synchronized)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomField():
        return $default(
            _that.id,
            _that.profileId,
            _that.label,
            _that.fieldType,
            _that.value,
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
            String profileId,
            String label,
            CustomFieldType fieldType,
            String? value,
            DateTime createdAt,
            DateTime updatedAt,
            DateTime? deletedAt,
            bool synchronized)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CustomField() when $default != null:
        return $default(
            _that.id,
            _that.profileId,
            _that.label,
            _that.fieldType,
            _that.value,
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

class _CustomField implements CustomField {
  const _CustomField(
      {required this.id,
      required this.profileId,
      required this.label,
      required this.fieldType,
      this.value,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synchronized});

  @override
  final String id;
  @override
  final String profileId;
  @override
  final String label;
  @override
  final CustomFieldType fieldType;
  @override
  final String? value;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final bool synchronized;

  /// Create a copy of CustomField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomFieldCopyWith<_CustomField> get copyWith =>
      __$CustomFieldCopyWithImpl<_CustomField>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomField &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.fieldType, fieldType) ||
                other.fieldType == fieldType) &&
            (identical(other.value, value) || other.value == value) &&
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
  int get hashCode => Object.hash(runtimeType, id, profileId, label, fieldType,
      value, createdAt, updatedAt, deletedAt, synchronized);

  @override
  String toString() {
    return 'CustomField(id: $id, profileId: $profileId, label: $label, fieldType: $fieldType, value: $value, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }
}

/// @nodoc
abstract mixin class _$CustomFieldCopyWith<$Res>
    implements $CustomFieldCopyWith<$Res> {
  factory _$CustomFieldCopyWith(
          _CustomField value, $Res Function(_CustomField) _then) =
      __$CustomFieldCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String profileId,
      String label,
      CustomFieldType fieldType,
      String? value,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      bool synchronized});
}

/// @nodoc
class __$CustomFieldCopyWithImpl<$Res> implements _$CustomFieldCopyWith<$Res> {
  __$CustomFieldCopyWithImpl(this._self, this._then);

  final _CustomField _self;
  final $Res Function(_CustomField) _then;

  /// Create a copy of CustomField
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? profileId = null,
    Object? label = null,
    Object? fieldType = null,
    Object? value = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? synchronized = null,
  }) {
    return _then(_CustomField(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      profileId: null == profileId
          ? _self.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      fieldType: null == fieldType
          ? _self.fieldType
          : fieldType // ignore: cast_nullable_to_non_nullable
              as CustomFieldType,
      value: freezed == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
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

// dart format on
