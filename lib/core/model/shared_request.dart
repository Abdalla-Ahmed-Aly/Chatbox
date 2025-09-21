import 'dart:convert';
String sharedRequestToJson(SharedRequest data) => json.encode(data.toJson());
class SharedRequest {
    SharedRequest({
        required this.username,
    });

    String username;
    Map<dynamic, dynamic> toJson() => {
        "username": username,
    };
}
