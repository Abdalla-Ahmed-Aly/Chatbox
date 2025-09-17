import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/updateProfile/data/model/photoRequest.dart';
import 'package:chatbox/features/updateProfile/data/model/photo_response/photo_response.dart';
import 'package:chatbox/features/updateProfile/domain/repositories/updateProfile_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class Updatephoto {
  UpdateProfileRepository repository;
  Updatephoto(this.repository);
  Future<Either<Failure, PhotoResponse>> call(PhotoRequest request) {
    return repository.updateProfilePhoto(request);
  }
}
