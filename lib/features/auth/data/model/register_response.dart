import 'dart:convert';
RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));


class RegisterResponse {
    RegisterResponse({
        required this.success,
        required this.token,
        required this.message,
    });

    bool success;
    String token;
    String message;

    factory RegisterResponse.fromJson(Map<dynamic, dynamic> json) => RegisterResponse(
        success: json["success"],
        token: json["Token"],
        message: json["message"],
    );


}
