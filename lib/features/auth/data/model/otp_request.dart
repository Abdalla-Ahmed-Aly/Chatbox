import 'dart:convert';
String otpRequestToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
    OtpRequest({
        required this.code,
        required this.email,
    });

    String code;
    String email;



    Map<dynamic, dynamic> toJson() => {
        "code": code,
        "email": email,
    };
}
