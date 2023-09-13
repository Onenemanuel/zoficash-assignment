import 'package:dart_ipify/dart_ipify.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/models/models.dart';
import 'package:zoficash/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;

  LoginBloc({required this.authBloc}) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginTogglePassword>(_onLoginTogglePassword);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginPhoneCodeChanged>(_onLoginPhoneCodeChanged);
    on<LoginPhoneNumberChanged>(_onLoginPhoneNumberChanged);
  }

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = const Email().dirty(event.email);
    emit(state.copyWith(email: email, status: LoginStatus.initial));
  }

  void _onLoginPhoneCodeChanged(
      LoginPhoneCodeChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      status: LoginStatus.initial,
      phoneCode: event.phoneCode,
    ));
  }

  void _onLoginPhoneNumberChanged(
      LoginPhoneNumberChanged event, Emitter<LoginState> emit) {
    final phoneNumber = const Phone().dirty(event.phoneNumber);
    emit(state.copyWith(
      status: LoginStatus.initial,
      phoneNumber: phoneNumber,
    ));
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = const Password().dirty(event.password);
    emit(state.copyWith(password: password, status: LoginStatus.initial));
  }

  void _onLoginTogglePassword(
      LoginTogglePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    // Validate email
    if (state.email.error != null) {
      return emit(state.copyWith(status: LoginStatus.invalid));
    }

    // Validate password
    if (state.password.error != null) {
      return emit(state.copyWith(status: LoginStatus.invalid));
    }

    // Change registration status to progress
    // This will show a progress dialog in UI
    emit(state.copyWith(status: LoginStatus.progress));

    // Get IP address and other fields
    var ip = await Ipify.ipv4();
    var email = state.email.value;
    var countryCode = state.phoneCode;
    var password = state.password.value;
    var phoneNumber = state.phoneNumber.value;

    // Make request and wait for response
    var response = await AuthService().login(
      ip: ip,
      email: email,
      password: password,
      countryCode: countryCode,
      phoneNumber: phoneNumber,
    );

    switch (response.successful) {
      case true:
        // Change auth status and user in auth bloc
        authBloc.add(Authenticate(response.user!));

        // Change login status to success
        return emit(state.copyWith(status: LoginStatus.success));
      case false:
        // Change login status to failure
        // Also, set message to be displayed to the users
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: response.message,
        ));

        // Change login status back to initial
        return emit(state.copyWith(status: LoginStatus.initial));
    }
  }
}
