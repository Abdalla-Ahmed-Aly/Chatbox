import 'dart:convert';
String registerRequestToJson(RegisterRequest data) => json.encode(data.toJson());

class RegisterRequest {
    RegisterRequest({
        required this.password,
        required this.phoneNumber,
        required this.email,
        required this.username,
    });

    String password;
    String phoneNumber;
    String email;
    String username;



    Map<dynamic, dynamic> toJson() => {
        "password": password,
        "phoneNumber": phoneNumber,
        "email": email,
        "username": username,
    };
}
