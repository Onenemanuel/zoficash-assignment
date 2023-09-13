import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/services/services.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final AuthBloc authBloc;

  VerificationBloc({required this.authBloc})
      : super(const VerificationState()) {
    on<VerificationFingerprintPressed>(_onVerificationFingerprintPressed);
    on<VerificationDeletePressed>(_onVerificationDeletePressed);
    on<VerificationCodeChanged>(_onVerificationCodeChanged);
  }

  void _onVerificationFingerprintPressed(
      VerificationFingerprintPressed event, Emitter<VerificationState> emit) {
    return;
  }

  void _onVerificationDeletePressed(
      VerificationDeletePressed event, Emitter<VerificationState> emit) {
    emit(state.copyWith(code: state.code.substring(0, state.code.length - 1)));
  }

  Future<void> _onVerificationCodeChanged(
      VerificationCodeChanged event, Emitter<VerificationState> emit) async {
    if (state.code.length < 6) {
      // Add digit to verification code
      emit(state.copyWith(code: state.code + event.code));
    }

    if (state.code.length == 6) {
      // Change verification status to progress
      // This will show a progress dialog in UI
      emit(state.copyWith(status: VerificationStatus.progress));

      // Get user from auth bloc
      var authUser = authBloc.state.authUser;

      var otp = state.code;
      var countryCode = authUser.countryCode;
      var phoneNumber = authUser.phoneNumber;

      // Remove country code from phone number
      phoneNumber = phoneNumber.replaceFirst(countryCode, "");

      // Make request and wait for response
      var response = await AuthService().verify(
        otp: otp,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      );

      switch (response.successful) {
        case true:
          // Change user verification status to true in auth bloc
          var user = authUser.copyWith(isAccountVerified: true);
          authBloc.add(AuthUpdateUser(user));

          // Change verification status to success
          return emit(state.copyWith(status: VerificationStatus.success));
        case false:
          // Change verification status to failure
          // Also, set message to be displayed to the users
          emit(state.copyWith(
            status: VerificationStatus.failure,
            message: response.message,
          ));

          // Change verification status back to initial
          return emit(state.copyWith(status: VerificationStatus.initial));
      }
    }
  }
}
