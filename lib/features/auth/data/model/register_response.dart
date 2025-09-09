import 'dart:convert';
RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));
class RegisterResponse {
    RegisterResponse({
        required this.success,
        required this.message,
    });

    bool success;
    String message;

    factory RegisterResponse.fromJson(Map<dynamic, dynamic> json) => RegisterResponse(
        success: json["success"],
        message: json["message"],
    );


}
