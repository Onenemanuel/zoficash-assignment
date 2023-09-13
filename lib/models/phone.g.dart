// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) => Phone(
      value: json['value'] as String? ?? "",
      error:
          $enumDecodeNullable(_$PhoneValidationErrorEnumMap, json['error']) ??
              PhoneValidationError.required,
    );

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'value': instance.value,
      'error': _$PhoneValidationErrorEnumMap[instance.error],
    };

const _$PhoneValidationErrorEnumMap = {
  PhoneValidationError.short: 'short',
  PhoneValidationError.required: 'required',
  PhoneValidationError.invalid: 'invalid',
};
