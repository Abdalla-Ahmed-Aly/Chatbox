abstract class RegisterStates {
}
class RegisterInitial extends RegisterStates {
}
class RegisterLoading extends RegisterStates {

}
class RegisterSuccess extends RegisterStates {
  final String message;
    final String token;

  RegisterSuccess(this.message, this.token);
}
class RegisterFailure extends RegisterStates {
  final String error;
  RegisterFailure(this.error);
}