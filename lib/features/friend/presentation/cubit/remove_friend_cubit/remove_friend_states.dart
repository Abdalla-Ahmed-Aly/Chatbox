abstract class RemoveFriendStates {}

class RemoveFriendInitial extends RemoveFriendStates {}

class RemoveFriendLoading extends RemoveFriendStates {}

class RemoveFriendSuccess extends RemoveFriendStates {
  final String message;
  RemoveFriendSuccess({required this.message});
}

class RemoveFriendError extends RemoveFriendStates {
  final String error;
  RemoveFriendError({required this.error});
}