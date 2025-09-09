import 'dart:convert';
String otpRequestToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
    OtpRequest({
        required this.otp,
        required this.type,
        required this.email,
    });

    String otp;
    String type;
    String email;



    Map<dynamic, dynamic> toJson() => {
        "otp": otp,
        "type": type,
        "email": email,
    };
}
