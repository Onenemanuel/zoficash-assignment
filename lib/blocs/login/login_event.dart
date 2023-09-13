part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPhoneCodeChanged extends LoginEvent {
  const LoginPhoneCodeChanged(this.phoneCode);

  final String phoneCode;

  @override
  List<Object> get props => [phoneCode];
}

class LoginPhoneNumberChanged extends LoginEvent {
  const LoginPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginTogglePassword extends LoginEvent {
  const LoginTogglePassword();
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
