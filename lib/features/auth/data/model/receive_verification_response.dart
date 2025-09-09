import 'dart:convert';
ReceiveVerificationResponse vericationResponseFromJson(String str) => ReceiveVerificationResponse.fromJson(json.decode(str));


class ReceiveVerificationResponse {
    ReceiveVerificationResponse({
        required this.success,
        required this.message,
    });

    bool success;
    String message;

    factory ReceiveVerificationResponse.fromJson(Map<dynamic, dynamic> json) => ReceiveVerificationResponse(
        success: json["success"],
        message: json["message"],
    );

}
