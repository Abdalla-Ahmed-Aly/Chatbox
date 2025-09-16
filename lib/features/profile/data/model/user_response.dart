import 'results.dart';

class UserResponse {
  final bool? success;
  final Results? results;

  const UserResponse({this.success, this.results});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    success: json['success'] as bool?,
    results: json['results'] == null
        ? null
        : Results.fromJson(json['results'] as Map<String, dynamic>),
  );
}
