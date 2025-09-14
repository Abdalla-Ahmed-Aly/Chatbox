class LoginResponse {
    LoginResponse({
        required this.success,
        required this.token,
        required this.message,
    });
    bool success;
    String token;
    String message;
	factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
				success: json['success'] ,
				message: json['message'] ,
				token: json['Token'],
			);


}
