import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/friend_request_list_use_case.dart';
import 'friend_request_states.dart';
@injectable
class FriendRequestCubit extends Cubit<FriendRequestStates> {
  FriendRequestCubit(this._friendRequest) : super(FriendRequestInitial());
  final FriendRequestListUseCase _friendRequest;
  Future<void> fetchFriendRequest()async{
    emit(FriendRequestLoading());
    final result=await _friendRequest();
    result.fold((failure)=>emit(FriendRequestError(error: failure.message)), (friends)=>emit(FriendRequestSuccess(friends: friends)));
  }
}
