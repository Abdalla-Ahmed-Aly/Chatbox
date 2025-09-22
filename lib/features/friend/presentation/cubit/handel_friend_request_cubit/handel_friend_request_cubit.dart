import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/handel_friend_request_model.dart';
import '../../../domain/use_cases/handel_friend_request_use_case.dart';
import 'handel_friend_request_states.dart';
@injectable
class HandelFriendRequestCubit extends Cubit<HandelFriendRequestStates> {
  HandelFriendRequestCubit(this._handelFriendRequest) : super(HandelFriendRequestInitial());
  final HandelFriendRequestUseCase _handelFriendRequest;
  Future<void>handelFriendRequest(HandelFriendRequestModel request)async{
    emit(HandelFriendRequestLoading());
    final result=await _handelFriendRequest(request);
    result.fold((failure)=>emit(HandelFriendRequestError(error: failure.message)), (message)=>emit(HandelFriendRequestSuccess(message: message)));
  }

}
