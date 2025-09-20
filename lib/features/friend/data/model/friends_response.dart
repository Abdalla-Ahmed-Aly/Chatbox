/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

FriendsResponse friendsResponseFromJson(String str) => FriendsResponse.fromJson(json.decode(str));

String friendsResponseToJson(FriendsResponse data) => json.encode(data.toJson());

class FriendsResponse {
    FriendsResponse({
        required this.success,
        required this.results,
    });

    bool success;
    Results results;

    factory FriendsResponse.fromJson(Map<dynamic, dynamic> json) => FriendsResponse(
        success: json["success"],
        results: Results.fromJson(json["results"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "success": success,
        "results": results.toJson(),
    };
}

class Results {
    Results({
        required this.friends,
    });

    List<Friend> friends;

    factory Results.fromJson(Map<dynamic, dynamic> json) => Results(
        friends: List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
    };
}

class Friend {
    Friend({
        required this.profilePic,
        required this.bio,
        required this.id,
        required this.firstLetter,
        required this.username,
        required this.status,
    });

    ProfilePic profilePic;
    String bio;
    String id;
    String firstLetter;
    String username;
    String status;

    factory Friend.fromJson(Map<dynamic, dynamic> json) => Friend(
        profilePic: ProfilePic.fromJson(json["profilePic"]),
        bio: json["bio"],
        id: json["_id"],
        firstLetter: json["firstLetter"],
        username: json["username"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "profilePic": profilePic.toJson(),
        "bio": bio,
        "_id": id,
        "firstLetter": firstLetter,
        "username": username,
        "status": status,
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
