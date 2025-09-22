import 'dart:convert';
FriendRequestListResponse friendRequestListResponseFromJson(String str) => FriendRequestListResponse.fromJson(json.decode(str));

class FriendRequestListResponse {
    FriendRequestListResponse({
        required this.success,
        required this.count,
        required this.results,
    });

    bool success;
    int count;
    Results results;

    factory FriendRequestListResponse.fromJson(Map<dynamic, dynamic> json) => FriendRequestListResponse(
        success: json["success"],
        count: json["count"],
        results: Results.fromJson(json["results"]),
    );

}

class Results {
    Results({
        required this.friendRequests,
    });

    List<FriendRequest> friendRequests;

    factory Results.fromJson(Map<dynamic, dynamic> json) => Results(
        friendRequests: List<FriendRequest>.from(json["friendRequests"].map((x) => FriendRequest.fromJson(x))),
    );


}

class FriendRequest {
    FriendRequest({
        required this.profilePic,
        required this.bio,
        required this.id,
        required this.username,
    });

    ProfilePic profilePic;
    String bio;
    String id;
    String username;

    factory FriendRequest.fromJson(Map<dynamic, dynamic> json) => FriendRequest(
        profilePic: ProfilePic.fromJson(json["profilePic"]),
        bio: json["bio"],
        id: json["_id"],
        username: json["username"],
    );

    Map<dynamic, dynamic> toJson() => {
        "profilePic": profilePic.toJson(),
        "bio": bio,
        "_id": id,
        "username": username,
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
