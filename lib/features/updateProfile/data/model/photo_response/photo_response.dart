
import 'results.dart';

class PhotoResponse {
	final bool? success;
	final String? message;
	final Results? results;

	const PhotoResponse({this.success, this.message, this.results});

	factory PhotoResponse.fromJson(Map<String, dynamic> json) => PhotoResponse(
				success: json['success'] as bool?,
				message: json['message'] as String?,
				results: json['results'] == null
						? null
						: Results.fromJson(json['results'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'success': success,
				'message': message,
				'results': results?.toJson(),
			};
}
