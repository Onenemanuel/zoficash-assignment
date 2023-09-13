import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zoficash/constants/constants.dart';

import 'package:zoficash/models/models.dart';

class AuthService {
  factory AuthService() {
    return _instance;
  }

  AuthService._internal();
  static final AuthService _instance = AuthService._internal();

  static const baseUrl = AppStrings.baseUrl;
  static const requestTimeout = AppStrings.requestTimeout;

  Future<({bool successful, String? message, User? user})> register({
    required String ip,
    required String email,
    required String access,
    required String password,
    required String countryCode,
    required String phoneNumber,
    required String repeatPassword,
  }) async {
    try {
      final response = await http.Client()
          .post(
            Uri.parse("$baseUrl/account-registration"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "ip": ip,
              "access": access,
              "password": password,
              "country_code": countryCode,
              "phone_number": phoneNumber,
              "repeat_password": repeatPassword,
              if (email.isNotEmpty) "email": email,
            }),
          )
          .timeout(requestTimeout);

      switch (response.statusCode) {
        case 200:
          final userJson = json.decode(response.body) as Map<String, dynamic>;
          User user = User.fromJson(userJson);
          return (successful: true, message: null, user: user);
        case 422:
          var body = json.decode(response.body) as Map<String, dynamic>;
          var message = body["errors"][0].toString();
          return (successful: false, message: message, user: null);
        default:
          throw Exception();
      }
    } catch (error) {
      return (
        user: null,
        successful: false,
        message: "Sorry, something went wrong",
      );
    }
  }

  Future<({bool successful, String? message, User? user})> login({
    required String ip,
    required String email,
    required String password,
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.Client()
          .post(
            Uri.parse("$baseUrl/account-login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "ip": ip,
              "password": password,
              "country_code": countryCode,
              "phone_number": phoneNumber,
              if (email.isNotEmpty) "email": email,
            }),
          )
          .timeout(requestTimeout);

      switch (response.statusCode) {
        case 200:
          final userJson = json.decode(response.body) as Map<String, dynamic>;
          User user = User.fromJson(userJson);
          return (successful: true, message: null, user: user);
        case 422:
          var body = json.decode(response.body) as Map<String, dynamic>;
          var message = body["errors"][0].toString();
          return (successful: false, message: message, user: null);
        default:
          throw Exception();
      }
    } catch (error) {
      return (
        user: null,
        successful: false,
        message: "Sorry, something went wrong",
      );
    }
  }

  Future<({bool successful, String? message})> verify({
    required String otp,
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.Client()
          .patch(
            Uri.parse("$baseUrl/verify-account-with-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "otp": otp,
              "country_code": countryCode,
              "phone_number": phoneNumber,
            }),
          )
          .timeout(requestTimeout);

      switch (response.statusCode) {
        case 200:
          return (successful: true, message: null);
        case 422:
          var body = json.decode(response.body) as Map<String, dynamic>;
          var message = body["errors"][0].toString();
          return (successful: false, message: message);
        default:
          throw Exception();
      }
    } catch (error) {
      return (successful: false, message: "Sorry, something went wrong");
    }
  }

  Future<({bool successful, String? message})> setupSecurityQuestion({
    required User authUser,
    required String answer,
    required String question,
  }) async {
    try {
      final response = await http.Client()
          .post(
            Uri.parse(
                "$baseUrl/setup-security-question/${authUser.securityQuestionSetupId}"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "security_question": question,
              "security_answer": answer,
            }),
          )
          .timeout(requestTimeout);

      switch (response.statusCode) {
        case 200:
          return (successful: true, message: null);
        case 422:
          var body = json.decode(response.body) as Map<String, dynamic>;
          var message = body["errors"][0].toString();
          return (successful: false, message: message);
        default:
          throw Exception();
      }
    } catch (error) {
      return (successful: false, message: "Sorry, something went wrong");
    }
  }
}
