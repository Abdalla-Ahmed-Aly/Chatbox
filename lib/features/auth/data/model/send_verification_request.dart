import 'dart:convert';
String vericationRequestToJson(SendVerificationRequest data) => json.encode(data.toJson());

class SendVerificationRequest {
    SendVerificationRequest({
        required this.email,
    });
    String email;
    Map<dynamic, dynamic> toJson() => {
        "email": email,
    };
}
