abstract class ConfirmOtpStates {}
class ConfirmOtpInitialState extends ConfirmOtpStates {}
class ConfirmOtpLoadingState extends ConfirmOtpStates {}
class ConfirmOtpSuccessState extends ConfirmOtpStates {
  final String message;
  ConfirmOtpSuccessState(this.message);
  //there is a token i don't save it so i will take the message only
}
class ConfirmOtpErrorState extends ConfirmOtpStates {
  final String error;
  ConfirmOtpErrorState(this.error);
}