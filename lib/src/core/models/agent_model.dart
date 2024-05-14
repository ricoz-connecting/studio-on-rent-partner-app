// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgentModel {
  final String name;
  final String uuid;
  final String phoneNumber;
  final bool verified;
  final String? businessname;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final List<String> service;
  final List<String> addons;
  final Uint8List photoUrl;
  AgentModel({
    required this.name,
    required this.uuid,
    required this.phoneNumber,
    required this.verified,
    this.businessname,
    required this.address,
    required this.city,
    required this.pincode,
    required this.state,
    required this.service,
    required this.addons,
    required this.photoUrl,
  });

  AgentModel copyWith({
    String? name,
    String? uuid,
    String? phoneNumber,
    bool? verified,
    String? businessname,
    String? address,
    String? city,
    String? pincode,
    String? state,
    List<String>? service,
    List<String>? addons,
    Uint8List? photoUrl,
  }) {
    return AgentModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verified: verified ?? this.verified,
      businessname: businessname ?? this.businessname,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      service: service ?? this.service,
      addons: addons ?? this.addons,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uuid': uuid,
      'phoneNumber': phoneNumber,
      'verified': verified,
      'businessname': businessname,
      'address': address,
      'city': city,
      'pincode': pincode,
      'state': state,
      'service': service,
      'addons': addons,
      'photoUrl': photoUrl.toString(),
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      name: map['name'] as String,
      uuid: map['uuid'] as String,
      phoneNumber: map['phoneNumber'] as String,
      verified: map['verified'] as bool,
      businessname:
          map['businessname'] != null ? map['businessname'] as String : null,
      address: map['address'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
      state: map['state'] as String,
      service: List<String>.from(
        (map['service'] as List<String>),
      ),
      addons: List<String>.from(
        (map['addons'] as List<String>),
      ),
      photoUrl: Uint8List.fromList(map['photoUrl']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentModel(name: $name, uuid: $uuid, phoneNumber: $phoneNumber, verified: $verified, businessname: $businessname, address: $address, city: $city, pincode: $pincode, state: $state, service: $service, addons: $addons, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant AgentModel other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uuid.hashCode ^
        phoneNumber.hashCode ^
        verified.hashCode ^
        businessname.hashCode ^
        address.hashCode ^
        city.hashCode ^
        pincode.hashCode ^
        state.hashCode ^
        service.hashCode ^
        addons.hashCode ^
        photoUrl.hashCode;
  }
}
