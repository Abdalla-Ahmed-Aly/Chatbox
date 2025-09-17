import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/photo_response/photo_response.dart';
import 'package:chatbox/features/updateProfile/data/model/update_profile_request.dart';
import 'package:chatbox/features/updateProfile/domain/entity/update_profile_Entity.dart';
import 'package:chatbox/features/updateProfile/domain/repositories/updateProfile_repositories.dart';
import 'package:chatbox/features/updateProfile/presentation/cubit/updateProfile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// @singleton
@injectable
class UpdateprofileCubit extends Cubit<UpdateprofileState> {
  UpdateProfileRepository updateProfileRepository;
  UpdateprofileCubit({required this.updateProfileRepository})
    : super(UpdateprofileInitial());

  Future<UpdateProfileEntity> updateProfile(
    UpdateProfileRequest requset,
  ) async {
    emit(UpdateprofileLoading());
    final result = await updateProfileRepository.updateProfile(requset);

    return result.fold(
      (error) {
        emit(UpdateprofileFailure(error.message));
        throw Exception(error.message);
      },
      (response) {
        emit(UpdateprofileSuccess(response));
        return response;
      },
    );
  }

  Future<PhotoResponse> updateProfilePhoto(PhotoRequest requset) async {
    emit(UpdateprofilePhotoLoading());
    final result = await updateProfileRepository.updateProfilePhoto(requset);

    return result.fold(
      (error) {
        emit(UpdateprofilePhotoFailure(error.message));
        throw Exception(error.message);
      },
      (response) {
        emit(UpdateprofilePhotoSuccess(response));
        return response;
      },
    );
  }
}
