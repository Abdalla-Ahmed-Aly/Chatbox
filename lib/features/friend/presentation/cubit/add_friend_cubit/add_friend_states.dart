abstract class AddFriendStates {}

class AddFriendInitial extends AddFriendStates {}

class AddFriendLoading extends AddFriendStates {}

class AddFriendSuccess extends AddFriendStates {
  final String message;
  AddFriendSuccess({required this.message});
}

class AddFriendError extends AddFriendStates {
  final String error;

  AddFriendError({required this.error});
}