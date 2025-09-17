
import 'package:chatbox/features/profile/data/model/results.dart';



class UpdateProfileResponse {
	final bool? success;
	final String? message;
	final Results? results;

	const UpdateProfileResponse({this.success, this.message, this.results});

	factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
		return UpdateProfileResponse(
			success: json['success'] as bool?,
			message: json['message'] as String?,
			results: json['results'] == null
						? null
						: Results.fromJson(json['results'] as Map<String, dynamic>),
		);
	}




}
