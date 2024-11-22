import 'dart:convert';
import 'dart:io';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String? email;
  final String? phone;
  final String name;
  final String? avatar;
  final File? avatarFile;
  final String? gender;
  final String? businessName;
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;

  User({
    required this.id,
    this.email,
    this.phone,
    required this.name,
    this.avatar,
    this.avatarFile,
    this.gender,
    this.businessName,
    required this.address,
    required this.city,
    required this.pincode,
    required this.state,
    required this.country,
  });

  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? name,
    String? avatar,
    File? avatarFile,
    String? gender,
    String? businessName,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        avatarFile: avatarFile ?? this.avatarFile,
        gender: gender ?? this.gender,
        businessName: businessName ?? this.businessName,
        address: address ?? this.address,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        state: state ?? this.state,
        country: country ?? this.country,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        avatar: json["avatar"],
        gender: json["gender"],
        businessName: json["businessName"],
        address: json["address"],
        city: json["city"],
        pincode: json["pincode"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "avatar": avatar,
        "gender": gender,
        "businessName": businessName,
        "address": address,
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
      };
}
