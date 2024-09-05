class Profile {
  String? phone;
  String? gender;
  String? email;
  String? username;
  String? name;
  String? address;
  String? city;
  String? pincode;
  String? state;
  String? country;
  String? avatar;
  String? businessName;
  String? latitude;
  String? longitude;

  Profile({
    this.phone,
    this.email,
    this.gender,
    this.username,
    this.name,
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
    this.avatar,
    this.businessName,
    this.latitude,
    this.longitude,
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

  Map<String, dynamic> toJson() {
    return {
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      if (name != null) 'name': name,
      if(gender!=null) 'gender' : gender,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (pincode != null) 'pincode': pincode,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (avatar != null) 'avatar': avatar,
      if (businessName != null) 'businessName': businessName,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
