// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      token: json['token'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String,
      countryCode: json['country_code'] as String,
      phoneNumber: json['phone_number'] as String,
      accountVerificationOtp: json['account_verification_otp'] as String?,
      securityQuestionSetupId: json['security_question_setup_id'] as String?,
      isAccountVerified: json['is_account_verified'] as bool,
      isSecurityQuestionSetup: json['is_security_question_setup'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'country_code': instance.countryCode,
      'phone_number': instance.phoneNumber,
      'is_account_verified': instance.isAccountVerified,
      'account_verification_otp': instance.accountVerificationOtp,
      'is_security_question_setup': instance.isSecurityQuestionSetup,
      'security_question_setup_id': instance.securityQuestionSetupId,
    };
