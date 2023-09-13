import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:zoficash/models/models.dart';

part 'auth_bloc.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthUpdateUser>(_onAuthUpdateUser);
    on<Unauthenticate>(_onUnauthenticate);
    on<Authenticate>(_onAuthenticate);
  }

  void _onAuthenticate(Authenticate event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authStatus: AuthStatus.authenticated,
      authUser: event.user,
    ));
  }

  void _onUnauthenticate(Unauthenticate event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      authStatus: AuthStatus.unauthenticated,
      authUser: User.empty,
    ));
  }

  void _onAuthUpdateUser(AuthUpdateUser event, Emitter<AuthState> emit) {
    emit(state.copyWith(authUser: event.user));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson(state);
  }
}
