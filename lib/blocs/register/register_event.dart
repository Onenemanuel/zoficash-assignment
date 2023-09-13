part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPhoneCodeChanged extends RegisterEvent {
  const RegisterPhoneCodeChanged(this.phoneCode);

  final String phoneCode;

  @override
  List<Object> get props => [phoneCode];
}

class RegisterPhoneNumberChanged extends RegisterEvent {
  const RegisterPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterRepeatPasswordChanged extends RegisterEvent {
  const RegisterRepeatPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterTogglePassword extends RegisterEvent {
  const RegisterTogglePassword();
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
