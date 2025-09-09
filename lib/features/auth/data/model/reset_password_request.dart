import 'dart:convert';
String resetPasswordRequestToJson(ResetPasswordRequest data) => json.encode(data.toJson());

class ResetPasswordRequest {
    ResetPasswordRequest({
        required this.newPassword,
        required this.confirmPassword,
        required this.email,
    });

    String newPassword;
    String confirmPassword;
    String email;



    Map<dynamic, dynamic> toJson() => {
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
        "email": email,
    };
}
