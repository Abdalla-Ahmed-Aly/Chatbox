import 'profile_pic.dart';

class Results {
  final ProfilePic? profilePic;

  const Results({this.profilePic});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    profilePic: json['profilePic'] == null
        ? null
        : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'profilePic': profilePic?.toJson()};
}
