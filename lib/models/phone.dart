import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

enum PhoneValidationError {
  short("Phone number must contain atleast 9 digits"),
  required("Required"),
  invalid("Invalid");

  const PhoneValidationError(this.value);

  final String value;
}

@JsonSerializable(explicitToJson: true)
class Phone extends Equatable {
  const Phone({
    this.value = "",
    this.error = PhoneValidationError.required,
  });

  final String value;
  final PhoneValidationError? error;

  Phone dirty(String? value) {
    return Phone(
      value: value ?? this.value,
      error: validator(value ?? this.value),
    );
  }

  PhoneValidationError? validator(String value) {
    if (value.isEmpty) return PhoneValidationError.required;

    if (value.length < 9) return PhoneValidationError.short;

    if (value.length > 9) return PhoneValidationError.invalid;

    if (!value.contains(RegExp(r'[0-9]'))) return PhoneValidationError.invalid;

    return null;
  }

  Phone copyWith({
    String? value,
    PhoneValidationError? error,
  }) {
    return Phone(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [value, error];

  factory Phone.fromJson(Map<String, dynamic> map) => _$PhoneFromJson(map);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
