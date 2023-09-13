part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

extension AuthStatusX on AuthStatus {
  bool get authenticated => this == AuthStatus.authenticated;
  bool get unauthenticated => this == AuthStatus.unauthenticated;
}

@JsonSerializable(explicitToJson: true)
class AuthState extends Equatable {
  const AuthState({
    this.authUser = User.empty,
    this.authStatus = AuthStatus.unauthenticated,
  });

  final User authUser;
  final AuthStatus authStatus;

  AuthState copyWith({
    User? authUser,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      authUser: authUser ?? this.authUser,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object> get props => [authUser, authStatus];

  factory AuthState.fromJson(Map<String, dynamic> map) =>
      _$AuthStateFromJson(map);

  Map<String, dynamic> toJson(AuthState state) => _$AuthStateToJson(state);
}
