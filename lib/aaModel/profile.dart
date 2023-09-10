class ProfileResponse {
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;

  ProfileResponse({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      email: json['data']['email'],
      firstName: json['data']['first_name'],
      lastName: json['data']['last_name'],
      profileImage: json['data']['profile_image'],
    );
  }
}
