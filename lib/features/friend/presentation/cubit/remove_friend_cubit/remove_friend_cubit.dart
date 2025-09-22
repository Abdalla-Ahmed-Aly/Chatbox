import 'package:chatbox/features/friend/presentation/cubit/remove_friend_cubit/remove_friend_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/model/shared_request.dart';
import '../../../domain/use_cases/remove_friend_use_case.dart';
@injectable
class RemoveFriendCubit extends Cubit<RemoveFriendStates> {
  RemoveFriendCubit(this._removeFriend) : super(RemoveFriendInitial());
final RemoveFriendUseCase _removeFriend;
Future<void>removeFriend(SharedRequest request)async{
  emit(RemoveFriendLoading());
  final result=await _removeFriend(request);
  result.fold((error) =>emit(RemoveFriendError(error: error.message)) , (message) =>emit(RemoveFriendSuccess(message: message)) ,);
}

}
