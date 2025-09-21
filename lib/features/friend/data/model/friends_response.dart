

import 'dart:convert';

FriendsResponse friendsResponseFromJson(String str) => FriendsResponse.fromJson(json.decode(str));



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


}

class Results {
    Results({
        required this.friends,
    });

    List<Friend> friends;

    factory Results.fromJson(Map<dynamic, dynamic> json) => Results(
        friends: List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
    );


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


}
