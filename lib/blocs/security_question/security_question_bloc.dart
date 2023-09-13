import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zoficash/blocs/blocs.dart';
import 'package:zoficash/services/services.dart';

part 'security_question_event.dart';
part 'security_question_state.dart';

class SecurityQuestionBloc
    extends Bloc<SecurityQuestionEvent, SecurityQuestionState> {
  final AuthBloc authBloc;

  SecurityQuestionBloc({required this.authBloc})
      : super(const SecurityQuestionState()) {
    on<SecurityQuestionSubmitted>(_onSecurityQuestionSubmitted);
    on<SecurityQuestionChanged>(_onSecurityQuestionChanged);
    on<SecurityAnswerChanged>(_onSecurityAnswerChanged);
  }

  void _onSecurityQuestionChanged(
      SecurityQuestionChanged event, Emitter<SecurityQuestionState> emit) {
    emit(state.copyWith(
      status: SecurityQuestionStatus.initial,
      question: event.question,
    ));
  }

  void _onSecurityAnswerChanged(
      SecurityAnswerChanged event, Emitter<SecurityQuestionState> emit) {
    emit(state.copyWith(
      status: SecurityQuestionStatus.initial,
      answer: event.answer,
    ));
  }

  Future<void> _onSecurityQuestionSubmitted(SecurityQuestionSubmitted event,
      Emitter<SecurityQuestionState> emit) async {
    // Validate question
    if (state.question.isEmpty) {
      return emit(state.copyWith(status: SecurityQuestionStatus.invalid));
    }

    // Validate answer
    if (state.answer.isEmpty) {
      return emit(state.copyWith(status: SecurityQuestionStatus.invalid));
    }

    // Change security question status to progress
    // This will show a progress dialog in UI
    emit(state.copyWith(status: SecurityQuestionStatus.progress));

    // Get user from auth bloc
    var authUser = authBloc.state.authUser;

    // Make request and wait for response
    var response = await AuthService().setupSecurityQuestion(
      question: state.question,
      answer: state.answer,
      authUser: authUser,
    );

    switch (response.successful) {
      case true:
        // Change user verification status to true in auth bloc
        var user = authUser.copyWith(isSecurityQuestionSetup: true);
        authBloc.add(AuthUpdateUser(user));

        // Change SecurityQuestion status to success
        return emit(state.copyWith(status: SecurityQuestionStatus.success));
      case false:
        // Change SecurityQuestion status to failure
        // Also, set message to be displayed to the users
        emit(state.copyWith(
          status: SecurityQuestionStatus.failure,
          message: response.message,
        ));

        // Change SecurityQuestion status back to initial
        return emit(state.copyWith(status: SecurityQuestionStatus.initial));
    }
  }
}
