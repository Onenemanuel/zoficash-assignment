// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      authUser: json['authUser'] == null
          ? User.empty
          : User.fromJson(json['authUser'] as Map<String, dynamic>),
      authStatus:
          $enumDecodeNullable(_$AuthStatusEnumMap, json['authStatus']) ??
              AuthStatus.unauthenticated,
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'authUser': instance.authUser.toJson(),
      'authStatus': _$AuthStatusEnumMap[instance.authStatus]!,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.unauthenticated: 'unauthenticated',
};
