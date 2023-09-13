import 'package:dart_ipify/dart_ipify.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/models/models.dart';
import 'package:zoficash/services/services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthBloc authBloc;

  RegisterBloc({required this.authBloc}) : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterTogglePassword>(_onRegisterTogglePassword);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterPhoneCodeChanged>(_onRegisterPhoneCodeChanged);
    on<RegisterPhoneNumberChanged>(_onRegisterPhoneNumberChanged);
    on<RegisterRepeatPasswordChanged>(_onRegisterRepeatPasswordChanged);
  }

  void _onRegisterEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final email = const Email().dirty(event.email);
    emit(state.copyWith(email: email, status: RegisterStatus.initial));
  }

  void _onRegisterPhoneCodeChanged(
      RegisterPhoneCodeChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      status: RegisterStatus.initial,
      phoneCode: event.phoneCode,
    ));
  }

  void _onRegisterPhoneNumberChanged(
      RegisterPhoneNumberChanged event, Emitter<RegisterState> emit) {
    final phoneNumber = const Phone().dirty(event.phoneNumber);
    emit(state.copyWith(
      status: RegisterStatus.initial,
      phoneNumber: phoneNumber,
    ));
  }

  void _onRegisterPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    final password = const Password().dirty(event.password);
    final repeatPassword = const Password().dirty(state.repeatPassword.value);

    emit(state.copyWith(
      repeatPassword: repeatPassword,
      status: RegisterStatus.initial,
      password: password,
    ));
  }

  void _onRegisterRepeatPasswordChanged(
      RegisterRepeatPasswordChanged event, Emitter<RegisterState> emit) {
    final repeatPassword = const Password().dirty(event.password);
    final password = const Password().dirty(state.password.value);

    emit(state.copyWith(
      repeatPassword: repeatPassword,
      status: RegisterStatus.initial,
      password: password,
    ));
  }

  void _onRegisterTogglePassword(
      RegisterTogglePassword event, Emitter<RegisterState> emit) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    // Validate email
    if (state.email.error != null) {
      return emit(state.copyWith(status: RegisterStatus.invalid));
    }

    // Validate password
    if (state.password.error != null) {
      return emit(state.copyWith(status: RegisterStatus.invalid));
    }

    // Validate repeat password
    if (state.repeatPassword.error != null) {
      return emit(state.copyWith(status: RegisterStatus.invalid));
    }

    // Validat password mismatch
    if (state.password != state.repeatPassword) {
      return emit(state.copyWith(
        status: RegisterStatus.invalid,
        password: state.password.copyWith(
          error: PasswordValidationError.mismatch,
        ),
        repeatPassword: state.repeatPassword.copyWith(
          error: PasswordValidationError.mismatch,
        ),
      ));
    }

    // Change registration status to progress
    // This will show a progress dialog in UI
    emit(state.copyWith(status: RegisterStatus.progress));

    // Get IP address and other fields
    var ip = await Ipify.ipv4();
    var email = state.email.value;
    var access = "employee";
    var countryCode = state.phoneCode;
    var password = state.password.value;
    var phoneNumber = state.phoneNumber.value;
    var repeatPassword = state.repeatPassword.value;

    // Make request and wait for response
    var response = await AuthService().register(
      ip: ip,
      email: email,
      access: access,
      password: password,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
      repeatPassword: repeatPassword,
    );

    switch (response.successful) {
      case true:
        // Change auth status and user in auth bloc
        authBloc.add(Authenticate(response.user!));

        // Change registration status to success
        return emit(state.copyWith(status: RegisterStatus.success));
      case false:
        // Change registration status to failure
        // Also, set message to be displayed to the users
        emit(state.copyWith(
          status: RegisterStatus.failure,
          message: response.message,
        ));

        // Change registration status back to initial
        return emit(state.copyWith(status: RegisterStatus.initial));
    }
  }
}
