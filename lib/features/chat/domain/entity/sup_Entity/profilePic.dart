import 'package:equatable/equatable.dart';

class ProfilePic extends Equatable {
  final String secure_url;
  final String public_id;
  const ProfilePic({required this.secure_url, required this.public_id});

  @override
  // TODO: implement props
  List<Object?> get props => [public_id];
}