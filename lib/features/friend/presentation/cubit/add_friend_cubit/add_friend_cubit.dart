import 'package:chatbox/core/model/shared_request.dart';
import 'package:chatbox/features/friend/domain/use_cases/add_friend_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'add_friend_states.dart';
@Injectable()
class AddFriendCubit extends Cubit<AddFriendStates> {
  AddFriendCubit(this._addFriend) : super(AddFriendInitial());
  final AddFriendUseCase _addFriend;

  Future<void> addFriend(SharedRequest request) async {
    emit(AddFriendLoading());
    final result = await _addFriend(request);
    result.fold((error) =>emit(AddFriendError(error: error.message)) , (message) =>emit(AddFriendSuccess(message: message)) ,);
  }
}
