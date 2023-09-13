import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    this.token,
    this.email,
    required this.id,
    required this.countryCode,
    required this.phoneNumber,
    this.accountVerificationOtp,
    this.securityQuestionSetupId,
    required this.isAccountVerified,
    required this.isSecurityQuestionSetup,
  });

  final String id;
  final String? token;
  final String? email;
  @JsonKey(name: "country_code")
  final String countryCode;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @JsonKey(name: "is_account_verified")
  final bool isAccountVerified;
  @JsonKey(name: "account_verification_otp")
  final String? accountVerificationOtp;
  @JsonKey(name: "is_security_question_setup")
  final bool isSecurityQuestionSetup;
  @JsonKey(name: "security_question_setup_id")
  final String? securityQuestionSetupId;

  static const empty = User(
    id: "",
    token: "",
    email: "",
    countryCode: "",
    phoneNumber: "",
    isAccountVerified: false,
    accountVerificationOtp: "",
    isSecurityQuestionSetup: false,
    securityQuestionSetupId: "",
  );

  User copyWith({
    String? id,
    String? token,
    String? email,
    String? countryCode,
    String? phoneNumber,
    bool? isAccountVerified,
    String? accountVerificationOtp,
    bool? isSecurityQuestionSetup,
    String? securityQuestionSetupId,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAccountVerified: isAccountVerified ?? this.isAccountVerified,
      accountVerificationOtp:
          accountVerificationOtp ?? this.accountVerificationOtp,
      isSecurityQuestionSetup:
          isSecurityQuestionSetup ?? this.isSecurityQuestionSetup,
      securityQuestionSetupId:
          securityQuestionSetupId ?? this.securityQuestionSetupId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        token,
        email,
        countryCode,
        phoneNumber,
        isAccountVerified,
        accountVerificationOtp,
        isSecurityQuestionSetup,
        securityQuestionSetupId,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
