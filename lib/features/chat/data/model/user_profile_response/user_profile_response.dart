
import 'results.dart';

class UserProfileResponse {
	final bool? success;
	final Results? results;

	const UserProfileResponse({this.success, this.results});

	factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
		return UserProfileResponse(
			success: json['success'] as bool?,
			results: json['results'] == null
						? null
						: Results.fromJson(json['results'] as Map<String, dynamic>),
		);
	}




}
