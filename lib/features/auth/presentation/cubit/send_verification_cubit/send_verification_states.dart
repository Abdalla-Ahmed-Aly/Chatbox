abstract class SendVerificationStates {
}
class SendVerificationInitial extends SendVerificationStates {
}
class SendVerificationLoading extends SendVerificationStates {
}
class SendVerificationSuccess extends SendVerificationStates {
  final String message;
  SendVerificationSuccess(this.message);
}
class SendVerificationFailure extends SendVerificationStates {
  final String error;
  SendVerificationFailure(this.error);
}