part of 'register_bloc.dart';

enum RegisterStatus { initial, invalid, progress, success, failure }

extension RegisterStatusX on RegisterStatus {
  bool get initial => this == RegisterStatus.initial;
  bool get invalid => this == RegisterStatus.invalid;
  bool get progress => this == RegisterStatus.progress;
  bool get success => this == RegisterStatus.success;
  bool get failure => this == RegisterStatus.failure;
}

@JsonSerializable(explicitToJson: true)
class RegisterState extends Equatable {
  const RegisterState({
    this.message = "",
    this.phoneCode = "+256",
    this.email = const Email(),
    this.passwordVisible = false,
    this.password = const Password(),
    this.phoneNumber = const Phone(),
    this.status = RegisterStatus.initial,
    this.repeatPassword = const Password(),
  });

  final Email email;
  final String message;
  final String phoneCode;
  final Password password;
  final Phone phoneNumber;
  final bool passwordVisible;
  final RegisterStatus status;
  final Password repeatPassword;

  RegisterState copyWith({
    Email? email,
    String? message,
    String? phoneCode,
    Phone? phoneNumber,
    Password? password,
    bool? passwordVisible,
    RegisterStatus? status,
    Password? repeatPassword,
  }) {
    return RegisterState(
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message,
      password: password ?? this.password,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  List<Object> get props => [
        email,
        status,
        message,
        password,
        phoneCode,
        phoneNumber,
        repeatPassword,
        passwordVisible,
      ];
}
