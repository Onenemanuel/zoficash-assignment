part of 'verification_bloc.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationCodeChanged extends VerificationEvent {
  const VerificationCodeChanged({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class VerificationFingerprintPressed extends VerificationEvent {
  const VerificationFingerprintPressed();
}

class VerificationDeletePressed extends VerificationEvent {
  const VerificationDeletePressed();
}
