class Profile {
  final String phone;
  final String email;
  final String username;
  final String name;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String avatar;
  final String businessName;
  final String latitude;
  final String longitude;

  Profile({
    required this.phone,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.city,
    required this.pincode,
    required this.state,
    required this.country,
    required this.avatar,
    required this.businessName,
    required this.latitude,
    required this.longitude,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      phone: json['phone'],
      email: json['email'],
      username: json['username'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      pincode: json['pincode'],
      state: json['state'],
      country: json['country'],
      avatar: json['avatar'],
      businessName: json['businessName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
