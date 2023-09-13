part of 'security_question_bloc.dart';

enum SecurityQuestionStatus { initial, invalid, progress, success, failure }

extension SecurityQuestionStatusX on SecurityQuestionStatus {
  bool get initial => this == SecurityQuestionStatus.initial;
  bool get invalid => this == SecurityQuestionStatus.invalid;
  bool get progress => this == SecurityQuestionStatus.progress;
  bool get success => this == SecurityQuestionStatus.success;
  bool get failure => this == SecurityQuestionStatus.failure;
}

@JsonSerializable()
class SecurityQuestionState extends Equatable {
  const SecurityQuestionState({
    this.answer = "",
    this.message = "",
    this.question = "What city were you born?",
    this.status = SecurityQuestionStatus.initial,
  });

  final String answer;
  final String message;
  final String question;
  final SecurityQuestionStatus status;

  SecurityQuestionState copyWith({
    String? answer,
    String? message,
    String? question,
    SecurityQuestionStatus? status,
  }) {
    return SecurityQuestionState(
      status: status ?? this.status,
      answer: answer ?? this.answer,
      message: message ?? this.message,
      question: question ?? this.question,
    );
  }

  @override
  List<Object> get props => [question, answer, status, message];
}
