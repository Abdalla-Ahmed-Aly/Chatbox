import 'dart:convert';

SearchUserResponse searchUserResponseFromJson(String str) => SearchUserResponse.fromJson(json.decode(str));

class SearchUserResponse {
    SearchUserResponse({
        required this.success,
        required this.count,
        required this.users,
    });

    bool success;
    int count;
    List<User> users;

    factory SearchUserResponse.fromJson(Map<dynamic, dynamic> json) => SearchUserResponse(
        success: json["success"],
        count: json["count"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "success": success,
        "count": count,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class User {
    User({
        required this.friendRequests,
        required this.stories,
        required this.profilePic,
        required this.bio,
        required this.groups,
        required this.isActivated,
        required this.friends,
        required this.createdAt,
        required this.phoneNumber,
        required this.isLoggedIn,
        required this.isConfirmed,
        required this.id,
        required this.email,
        required this.firstLetter,
        required this.mediaShared,
        required this.username,
        required this.status,
        required this.updatedAt,
    });

    List<dynamic> friendRequests;
    List<dynamic> stories;
    ProfilePic profilePic;
    String bio;
    List<dynamic> groups;
    bool isActivated;
    List<String> friends;
    DateTime createdAt;
    String phoneNumber;
    bool isLoggedIn;
    bool isConfirmed;
    String id;
    String email;
    String firstLetter;
    MediaShared mediaShared;
    String username;
    String status;
    DateTime updatedAt;

    factory User.fromJson(Map<dynamic, dynamic> json) => User(
        friendRequests: List<dynamic>.from(json["friendRequests"].map((x) => x)),
        stories: List<dynamic>.from(json["stories"].map((x) => x)),
        profilePic: ProfilePic.fromJson(json["profilePic"]),
        bio: json["bio"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        isActivated: json["isActivated"],
        friends: List<String>.from(json["friends"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        phoneNumber: json["phoneNumber"],
        isLoggedIn: json["isLoggedIn"],
        isConfirmed: json["isConfirmed"],
        id: json["_id"],
        email: json["email"],
        firstLetter: json["firstLetter"],
        mediaShared: MediaShared.fromJson(json["mediaShared"]),
        username: json["username"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "friendRequests": List<dynamic>.from(friendRequests.map((x) => x)),
        "stories": List<dynamic>.from(stories.map((x) => x)),
        "profilePic": profilePic.toJson(),
        "bio": bio,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "isActivated": isActivated,
        "friends": List<dynamic>.from(friends.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "phoneNumber": phoneNumber,
        "isLoggedIn": isLoggedIn,
        "isConfirmed": isConfirmed,
        "_id": id,
        "email": email,
        "firstLetter": firstLetter,
        "mediaShared": mediaShared.toJson(),
        "username": username,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class MediaShared {
    MediaShared({
        required this.images,
        required this.documents,
        required this.voices,
        required this.videos,
    });

    List<dynamic> images;
    List<dynamic> documents;
    List<dynamic> voices;
    List<dynamic> videos;

    factory MediaShared.fromJson(Map<dynamic, dynamic> json) => MediaShared(
        images: List<dynamic>.from(json["images"].map((x) => x)),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        voices: List<dynamic>.from(json["voices"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
    );

    Map<dynamic, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "voices": List<dynamic>.from(voices.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
    };
}

class ProfilePic {
    ProfilePic({
        required this.secureUrl,
        required this.publicId,
    });

    String secureUrl;
    String publicId;

    factory ProfilePic.fromJson(Map<dynamic, dynamic> json) => ProfilePic(
        secureUrl: json["secure_url"],
        publicId: json["public_id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "secure_url": secureUrl,
        "public_id": publicId,
    };
}
