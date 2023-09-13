import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email.g.dart';

enum EmailValidationError {
  invalid("Invalid");

  const EmailValidationError(this.value);

  final String value;
}

@JsonSerializable(explicitToJson: true)
class Email extends Equatable {
  const Email({this.value = "", this.error});

  final String value;
  final EmailValidationError? error;

  Email dirty(String? value) {
    return Email(
      value: value ?? this.value,
      error: validator(value ?? this.value),
    );
  }

  EmailValidationError? validator(String value) {
    if (value.isEmpty) return null;

    var hasMatch = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value);

    if (!hasMatch) return EmailValidationError.invalid;

    return null;
  }

  Email copyWith({
    String? value,
    EmailValidationError? error,
  }) {
    return Email(
      value: value ?? this.value,
      error: error,
    );
  }

  @override
  List<Object?> get props => [value, error];

  factory Email.fromJson(Map<String, dynamic> map) => _$EmailFromJson(map);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}
