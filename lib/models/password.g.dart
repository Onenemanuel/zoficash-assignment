// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) => Password(
      value: json['value'] as String? ?? "",
      error: $enumDecodeNullable(
              _$PasswordValidationErrorEnumMap, json['error']) ??
          PasswordValidationError.required,
    );

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'value': instance.value,
      'error': _$PasswordValidationErrorEnumMap[instance.error],
    };

const _$PasswordValidationErrorEnumMap = {
  PasswordValidationError.short: 'short',
  PasswordValidationError.mismatch: 'mismatch',
  PasswordValidationError.required: 'required',
};
