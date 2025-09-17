
import 'media_shared.dart';
import 'profile_pic.dart';

class User {
	final MediaShared? mediaShared;
	final ProfilePic? profilePic;
	final String? id;
	final String? username;
	final String? email;
	final String? phoneNumber;
	final String? bio;
	final List<dynamic>? friends;
	final List<dynamic>? groups;
	final List<dynamic>? stories;
	final String? status;
	final bool? isLoggedIn;
	final bool? isActivated;
	final bool? isConfirmed;
	final DateTime? createdAt;
	final DateTime? updatedAt;
	final String? firstLetter;
	final String? address;

	const User({
		this.mediaShared, 
		this.profilePic, 
		this.id, 
		this.username, 
		this.email, 
		this.phoneNumber, 
		this.bio, 
		this.friends, 
		this.groups, 
		this.stories, 
		this.status, 
		this.isLoggedIn, 
		this.isActivated, 
		this.isConfirmed, 
		this.createdAt, 
		this.updatedAt, 
		this.firstLetter, 
		this.address, 
	});

	factory User.fromJson(Map<String, dynamic> json) => User(
				mediaShared: json['mediaShared'] == null
						? null
						: MediaShared.fromJson(json['mediaShared'] as Map<String, dynamic>),
				profilePic: json['profilePic'] == null
						? null
						: ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
				id: json['_id'] as String?,
				username: json['username'] as String?,
				email: json['email'] as String?,
				phoneNumber: json['phoneNumber'] as String?,
				bio: json['bio'] as String?,
				friends: json['friends'] as List<dynamic>?,
				groups: json['groups'] as List<dynamic>?,
				stories: json['stories'] as List<dynamic>?,
				status: json['status'] as String?,
				isLoggedIn: json['isLoggedIn'] as bool?,
				isActivated: json['isActivated'] as bool?,
				isConfirmed: json['isConfirmed'] as bool?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
				firstLetter: json['firstLetter'] as String?,
				address: json['address'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'mediaShared': mediaShared?.toJson(),
				'profilePic': profilePic?.toJson(),
				'_id': id,
				'username': username,
				'email': email,
				'phoneNumber': phoneNumber,
				'bio': bio,
				'friends': friends,
				'groups': groups,
				'stories': stories,
				'status': status,
				'isLoggedIn': isLoggedIn,
				'isActivated': isActivated,
				'isConfirmed': isConfirmed,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'firstLetter': firstLetter,
				'address': address,
			};
}
