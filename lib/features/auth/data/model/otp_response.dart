import 'dart:convert';
OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));
class OtpResponse {
    OtpResponse({
        required this.accessToken,
        required this.refreshToken,
        required this.success,
        required this.message,
    });

    String accessToken;
    String refreshToken;
    bool success;
    String message;

    factory OtpResponse.fromJson(Map<dynamic, dynamic> json) => OtpResponse(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        success: json["success"],
        message: json["message"],
    );


}
