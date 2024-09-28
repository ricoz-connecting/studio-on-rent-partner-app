import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String id;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String email;
  final String phone;
  final String name;
  final String avatar;
  // final String gender;

  User({
    required this.id,
    required this.address,
    required this.city,
    required this.pincode,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
    required this.name,
    required this.avatar,
    // required this.gender,
  });

  User copyWith({
    String? id,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
    String? email,
    String? phone,
    String? name,
    String? avatar,
    String? gender,
  }) =>
      User(
        id: id ?? this.id,
        address: address ?? this.address,
        city: city ?? this.city,
        pincode: pincode ?? this.pincode,
        state: state ?? this.state,
        country: country ?? this.country,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        // gender: gender ?? this.gender,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        address: json["address"],
        city: json["city"],
        pincode: json["pincode"],
        state: json["state"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        avatar: json["avatar"],
        // gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address,
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
        "email": email,
        "phone": phone,
        "name": name,
        "avatar": avatar,
        // "gender": gender,
      };
}
