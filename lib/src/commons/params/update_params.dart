// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

class UpdateParams {
  final String status;
  final String scheduleId;

  UpdateParams({required this.status, required this.scheduleId});
}

class AgentUpdateParams {
  final String name;
  final String? businessname;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final List<String> service;
  final Uint8List photoUrl;

  AgentUpdateParams(
      {required this.name,
      required this.businessname,
      required this.address,
      required this.city,
      required this.pincode,
      required this.state,
      required this.service,
      required this.photoUrl});

  AgentUpdateParams copyWith({
    String? name,
    String? businessname,
    String? address,
    String? city,
    String? pincode,
    String? state,
    List<String>? service,
    Uint8List? photoUrl,
  }) {
    return AgentUpdateParams(
      name: name ?? this.name,
      businessname: businessname ?? this.businessname,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      service: service ?? this.service,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'businessname': businessname,
      'address': address,
      'city': city,
      'pincode': pincode,
      'state': state,
      'service': service,
     
    };
  }

  factory AgentUpdateParams.fromMap(Map<String, dynamic> map) {
    return AgentUpdateParams(
      name: map['name'] as String,
      businessname:
          map['businessname'] != null ? map['businessname'] as String : null,
      address: map['address'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
      state: map['state'] as String,
      service: List<String>.from((map['service'] as List<String>)),
      photoUrl: Uint8List.fromList(map['photoUrl']['map']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentUpdateParams.fromJson(String source) =>
      AgentUpdateParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentUpdateParams(name: $name, businessname: $businessname, address: $address, city: $city, pincode: $pincode, state: $state, service: $service, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant AgentUpdateParams other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.businessname == businessname &&
        other.address == address &&
        other.city == city &&
        other.pincode == pincode &&
        other.state == state &&
        listEquals(other.service, service) &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        businessname.hashCode ^
        address.hashCode ^
        city.hashCode ^
        pincode.hashCode ^
        state.hashCode ^
        service.hashCode ^
        photoUrl.hashCode;
  }
}
