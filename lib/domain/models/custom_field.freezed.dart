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

part of 'custom_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomField {
  String get id => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  CustomFieldType get fieldType => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool get synchronized => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomFieldCopyWith<CustomField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFieldCopyWith<$Res> {
  factory $CustomFieldCopyWith(
          CustomField value, $Res Function(CustomField) then) =
      _$CustomFieldCopyWithImpl<$Res, CustomField>;
  @useResult
  $Res call({
    String id,
    String profileId,
    String label,
    CustomFieldType fieldType,
    String? value,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? deletedAt,
    bool synchronized,
  });
}

/// @nodoc
class _$CustomFieldCopyWithImpl<$Res, $Val extends CustomField>
    implements $CustomFieldCopyWith<$Res> {
  _$CustomFieldCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as String,
      profileId: null == profileId ? _value.profileId : profileId as String,
      label: null == label ? _value.label : label as String,
      fieldType: null == fieldType ? _value.fieldType : fieldType as CustomFieldType,
      value: freezed == value ? _value.value : value as String?,
      createdAt: null == createdAt ? _value.createdAt : createdAt as DateTime,
      updatedAt: null == updatedAt ? _value.updatedAt : updatedAt as DateTime,
      deletedAt: freezed == deletedAt ? _value.deletedAt : deletedAt as DateTime?,
      synchronized: null == synchronized ? _value.synchronized : synchronized as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFieldImplCopyWith<$Res>
    implements $CustomFieldCopyWith<$Res> {
  factory _$$CustomFieldImplCopyWith(
          _$CustomFieldImpl value, $Res Function(_$CustomFieldImpl) then) =
      __$$CustomFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String profileId,
    String label,
    CustomFieldType fieldType,
    String? value,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? deletedAt,
    bool synchronized,
  });
}

/// @nodoc
class __$$CustomFieldImplCopyWithImpl<$Res>
    extends _$CustomFieldCopyWithImpl<$Res, _$CustomFieldImpl>
    implements _$$CustomFieldImplCopyWith<$Res> {
  __$$CustomFieldImplCopyWithImpl(
      _$CustomFieldImpl _value, $Res Function(_$CustomFieldImpl) _then)
      : super(_value, _then);

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
    return _then(_$CustomFieldImpl(
      id: null == id ? _value.id : id as String,
      profileId: null == profileId ? _value.profileId : profileId as String,
      label: null == label ? _value.label : label as String,
      fieldType: null == fieldType ? _value.fieldType : fieldType as CustomFieldType,
      value: freezed == value ? _value.value : value as String?,
      createdAt: null == createdAt ? _value.createdAt : createdAt as DateTime,
      updatedAt: null == updatedAt ? _value.updatedAt : updatedAt as DateTime,
      deletedAt: freezed == deletedAt ? _value.deletedAt : deletedAt as DateTime?,
      synchronized: null == synchronized ? _value.synchronized : synchronized as bool,
    ));
  }
}

/// @nodoc
class _$CustomFieldImpl implements _CustomField {
  const _$CustomFieldImpl({
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

  @override
  String toString() {
    return 'CustomField(id: $id, profileId: $profileId, label: $label, fieldType: $fieldType, value: $value, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, synchronized: $synchronized)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFieldImpl &&
            other.id == id &&
            other.profileId == profileId &&
            other.label == label &&
            other.fieldType == fieldType &&
            other.value == value &&
            other.createdAt == createdAt &&
            other.updatedAt == updatedAt &&
            other.deletedAt == deletedAt &&
            other.synchronized == synchronized);
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, profileId, label, fieldType, value, createdAt, updatedAt, deletedAt, synchronized);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFieldImplCopyWith<_$CustomFieldImpl> get copyWith =>
      __$$CustomFieldImplCopyWithImpl<_$CustomFieldImpl>(this, _$identity);
}

abstract class _CustomField implements CustomField {
  const factory _CustomField({
    required final String id,
    required final String profileId,
    required final String label,
    required final CustomFieldType fieldType,
    final String? value,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? deletedAt,
    required final bool synchronized,
  }) = _$CustomFieldImpl;

  @override
  String get id;
  @override
  String get profileId;
  @override
  String get label;
  @override
  CustomFieldType get fieldType;
  @override
  String? get value;
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
  _$$CustomFieldImplCopyWith<_$CustomFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
