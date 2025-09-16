import 'package:chatbox/core/failure/failure.dart';
import 'package:chatbox/features/profile/domain/entity/user_entity.dart';
import 'package:chatbox/features/profile/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
@injectable

class Getuser {
  Getuser({required this.userRepository});
  final UserRepository userRepository;
  Future<Either<Failure, UserEntity>> call() {
    return userRepository.getUserProfile();
  }
}
