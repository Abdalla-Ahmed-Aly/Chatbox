abstract class ResetPasswordStates {
}
class ResetPasswordInitial extends ResetPasswordStates {
}
class ResetPasswordLoading extends ResetPasswordStates {

}
class ResetPasswordSuccess extends ResetPasswordStates {
  final String message;
  ResetPasswordSuccess(this.message);
}
class ResetPasswordFailure extends ResetPasswordStates {
  final String error;
  ResetPasswordFailure(this.error);
}