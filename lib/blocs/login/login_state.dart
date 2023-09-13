part of 'login_bloc.dart';

enum LoginStatus { initial, invalid, progress, success, failure }

extension LoginStatusX on LoginStatus {
  bool get initial => this == LoginStatus.initial;
  bool get invalid => this == LoginStatus.invalid;
  bool get progress => this == LoginStatus.progress;
  bool get success => this == LoginStatus.success;
  bool get failure => this == LoginStatus.failure;
}

@JsonSerializable(explicitToJson: true)
class LoginState extends Equatable {
  const LoginState({
    this.message = "",
    this.phoneCode = "+256",
    this.email = const Email(),
    this.passwordVisible = false,
    this.password = const Password(),
    this.phoneNumber = const Phone(),
    this.status = LoginStatus.initial,
  });

  final Email email;
  final String message;
  final String phoneCode;
  final Phone phoneNumber;
  final Password password;
  final LoginStatus status;
  final bool passwordVisible;

  LoginState copyWith({
    Email? email,
    String? message,
    String? phoneCode,
    Password? password,
    Phone? phoneNumber,
    LoginStatus? status,
    bool? passwordVisible,
  }) {
    return LoginState(
      email: email ?? this.email,
      status: status ?? this.status,
      message: message ?? this.message,
      password: password ?? this.password,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
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
        passwordVisible,
      ];
}
