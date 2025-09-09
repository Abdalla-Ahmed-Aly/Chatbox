import 'dart:convert';
ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));



class ResetPasswordResponse {
    ResetPasswordResponse({
        required this.success,
        required this.message,
    });

    bool success;
    String message;

    factory ResetPasswordResponse.fromJson(Map<dynamic, dynamic> json) => ResetPasswordResponse(
        success: json["success"],
        message: json["message"],
    );


}
