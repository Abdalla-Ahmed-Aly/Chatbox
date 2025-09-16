
import 'user.dart';

class Results {
	final User? user;

	const Results({this.user});

	factory Results.fromJson(Map<String, dynamic> json) => Results(
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
			);


}
