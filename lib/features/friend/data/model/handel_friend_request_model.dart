
import 'dart:convert';



String handelFriendRequestModelToJson(HandelFriendRequestModel data) => json.encode(data.toJson());

class HandelFriendRequestModel {
    HandelFriendRequestModel({
        required this.action,
        required this.username,
    });

    String action;
    String username;

    Map<dynamic, dynamic> toJson() => {
        "action": action,
        "username": username,
    };
}
