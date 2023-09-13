part of 'verification_bloc.dart';

enum VerificationStatus { initial, invalid, progress, success, failure }

extension VerificationStatusX on VerificationStatus {
  bool get initial => this == VerificationStatus.initial;
  bool get invalid => this == VerificationStatus.invalid;
  bool get progress => this == VerificationStatus.progress;
  bool get success => this == VerificationStatus.success;
  bool get failure => this == VerificationStatus.failure;
}

@JsonSerializable()
class VerificationState extends Equatable {
  const VerificationState({
    this.code = "",
    this.message = "",
    this.status = VerificationStatus.initial,
  });

  final String code;
  final String message;
  final VerificationStatus status;

  VerificationState copyWith({
    String? code,
    String? message,
    VerificationStatus? status,
  }) {
    return VerificationState(
      code: code ?? this.code,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [code, status, message];
}
