import 'package:chatbox/features/chat/domain/entity/user_profile_entity.dart';
import 'package:chatbox/features/chat/domain/repositories/user_profile_repository.dart';
import 'package:chatbox/features/chat/domain/use_cases/getUserProfile.dart';
import 'package:chatbox/features/chat/presentation/cubit/get_user_Profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class GetUserProfileCubit extends Cubit<GetUserProfileState> {
  UserProfileRepository _profileRepository;
  // GetUserProfileCubit(super.initialState);
  GetUserProfileCubit(this._profileRepository) : super(GetUserProfileInitial());
  Future<UserProfileEntity> getUserProfile(Params params) async {
    // emit(GetUserProfileLoading());
    final result = await _profileRepository.getUserProfile(params);
    return result.fold(
      (error) {
        emit(GetUserProfileFailure(error.message));
        throw Exception(error.message);
      },
      (response) {
        emit(GetUserProfileSuccess(response));
        return response;
      },
    );
  }
}
