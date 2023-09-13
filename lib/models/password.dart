import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

enum PasswordValidationError {
  short("Password must contain atleast 6 characters"),
  mismatch("Passwords do not match"),
  required("Required");

  const PasswordValidationError(this.value);

  final String value;
}

@JsonSerializable(explicitToJson: true)
class Password extends Equatable {
  const Password({
    this.value = "",
    this.error = PasswordValidationError.required,
  });

  final String value;
  final PasswordValidationError? error;

  Password dirty(String? value) {
    return Password(
      value: value ?? this.value,
      error: validator(value ?? this.value),
    );
  }

  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.required;

    if (value.length < 6) return PasswordValidationError.short;

    return null;
  }

  Password copyWith({
    String? value,
    PasswordValidationError? error,
  }) {
    return Password(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [value, error];

  factory Password.fromJson(Map<String, dynamic> map) =>
      _$PasswordFromJson(map);

  Map<String, dynamic> toJson() => _$PasswordToJson(this);
}
