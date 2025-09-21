import 'dart:convert';
RemoveFriendResponse removeFriendResponseFromJson(String str) => RemoveFriendResponse.fromJson(json.decode(str));
class RemoveFriendResponse {
    RemoveFriendResponse({
        required this.success,
        required this.message,
        required this.results,
    });

    bool success;
    String message;
    Results results;

    factory RemoveFriendResponse.fromJson(Map<dynamic, dynamic> json) => RemoveFriendResponse(
        success: json["success"],
        message: json["message"],
        results: Results.fromJson(json["results"]),
    );


}

class Results {
    Results({
        required this.friends,
    });

    List<String> friends;

    factory Results.fromJson(Map<dynamic, dynamic> json) => Results(
        friends: List<String>.from(json["friends"].map((x) => x)),
    );


}
