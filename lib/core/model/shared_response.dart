import 'dart:convert';
SharedResponse resetPasswordResponseFromJson(String str) => SharedResponse.fromJson(json.decode(str));



class SharedResponse {
    SharedResponse({
        required this.success,
        required this.message,
    });

    bool success;
    String message;

    factory SharedResponse.fromJson(Map<dynamic, dynamic> json) => SharedResponse(
        success: json["success"],
        message: json["message"],
    );


}
