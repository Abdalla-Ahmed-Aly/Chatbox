class UpdateProfileRequest {
  final String? username;
  final String? phoneNumber;
  final String? address;
  final String? bio;

  const UpdateProfileRequest({
    this.username,
    this.phoneNumber,
    this.address,
    this.bio,
  });


   Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phoneNumber': phoneNumber,
      'address': address,
      'bio': bio,
    };
  }
}
