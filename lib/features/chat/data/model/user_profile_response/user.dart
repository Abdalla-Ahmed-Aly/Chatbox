


import 'package:chatbox/features/chat/data/model/user_profile_response/profile_pic.dart';

class User {
	final ProfilePicResponse? profilePic;
	final String? username;
	final String? email;
	final String? phoneNumber;
	final String? bio;
	final String? status;
	final String? address;

	const User({
		this.profilePic, 
		this.username, 
		this.email, 
		this.phoneNumber, 
		this.bio, 
		this.status, 
		this.address, 
	});

	factory User.fromJson(Map<String, dynamic> json) => User(
				profilePic: json['profilePic'] == null
						? null
						: ProfilePicResponse.fromJson(json['profilePic'] as Map<String, dynamic>),
				username: json['username'] as String?,
				email: json['email'] as String?,
				phoneNumber: json['phoneNumber'] as String?,
				bio: json['bio'] as String?,
				status: json['status'] as String?,
				address: json['address'] as String?,
			);

	
}
