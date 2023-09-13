// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
      value: json['value'] as String? ?? "",
      error: $enumDecodeNullable(_$EmailValidationErrorEnumMap, json['error']),
    );

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'value': instance.value,
      'error': _$EmailValidationErrorEnumMap[instance.error],
    };

const _$EmailValidationErrorEnumMap = {
  EmailValidationError.invalid: 'invalid',
};
