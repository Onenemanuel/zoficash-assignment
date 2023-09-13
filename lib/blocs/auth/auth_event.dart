part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Authenticate extends AuthEvent {
  const Authenticate(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class Unauthenticate extends AuthEvent {
  const Unauthenticate();
}

class AuthUpdateUser extends AuthEvent {
  const AuthUpdateUser(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
