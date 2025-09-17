
class ProfilePic {
	final String? secureUrl;
	final String? publicId;

	const ProfilePic({this.secureUrl, this.publicId});

	factory ProfilePic.fromJson(Map<String, dynamic> json) => ProfilePic(
				secureUrl: json['secure_url'] as String?,
				publicId: json['public_id'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'secure_url': secureUrl,
				'public_id': publicId,
			};
}
