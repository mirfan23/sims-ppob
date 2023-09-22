import 'dart:convert';

GetProfile getProfileFromJson(String str) =>
    GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  int status;
  String message;
  Data data;

  GetProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String email;
  String firstName;
  String lastName;
  String profileImage;

  Data({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
      };
}
