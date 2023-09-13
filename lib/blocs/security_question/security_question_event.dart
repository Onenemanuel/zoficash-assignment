part of 'security_question_bloc.dart';

abstract class SecurityQuestionEvent extends Equatable {
  const SecurityQuestionEvent();

  @override
  List<Object> get props => [];
}

class SecurityQuestionChanged extends SecurityQuestionEvent {
  const SecurityQuestionChanged({required this.question});

  final String question;

  @override
  List<Object> get props => [question];
}

class SecurityAnswerChanged extends SecurityQuestionEvent {
  const SecurityAnswerChanged({required this.answer});

  final String answer;

  @override
  List<Object> get props => [answer];
}

class SecurityQuestionSubmitted extends SecurityQuestionEvent {
  const SecurityQuestionSubmitted();
}
