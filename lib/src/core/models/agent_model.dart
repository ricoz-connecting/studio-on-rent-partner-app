// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class AgentModel {
  final String name;
  final String agentId;
  final String phoneNumber;
  final String isVerified;
  final String? businessname;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final List<String> service;

  final Uint8List photoUrl;
  final String status;
  AgentModel(
      {required this.name,
      required this.agentId,
      required this.phoneNumber,
      required this.isVerified,
      this.businessname,
      required this.address,
      required this.city,
      required this.pincode,
      required this.state,
      required this.service,
      required this.photoUrl,
      this.status = 'owner'});

  static empty() => AgentModel(
      name: 'name',
      agentId: 'agentId',
      phoneNumber: 'phoneNumber',
      isVerified: 'isVerified',
      address: 'address',
      city: 'city',
      pincode: 'pincode',
      state: 'state',
      service: ['service'],
      photoUrl: Uint8List.fromList([]));

  AgentModel copyWith({
    String? name,
    String? agentId,
    String? phoneNumber,
    String? isVerified,
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
      agentId: agentId ?? this.agentId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
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
      'agentId': agentId,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
      'businessname': businessname,
      'address': address,
      'city': city,
      'pincode': pincode,
      'state': state,
      'service': service,
      'photoUrl': photoUrl.toString(),
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    log(map['photoUrl'].toString());
    return AgentModel(
      name: map['name'] as String,
      agentId: map['agentId'] as String,
      phoneNumber: map['number'] as String,
      isVerified: map['isVerified'] as String,
      businessname: map['businessName'],
      address: map['address'] as String,
      city: map['city'] as String,
      pincode: map['pincode'] as String,
      state: map['state'] as String,
      service: List<String>.from(map['services']),
      photoUrl: Uint8List.fromList(List<int>.from(map['photoUrl']['data'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgentModel.fromJson(String source) =>
      AgentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AgentModel(name: $name, agentId: $agentId, phoneNumber: $phoneNumber, isVerified: $isVerified, businessname: $businessname, address: $address, city: $city, pincode: $pincode, state: $state, service: $service, photoUrl: $photoUrl)';
  }

  @override
  int get hashCode {
    return name.hashCode ^
        agentId.hashCode ^
        phoneNumber.hashCode ^
        isVerified.hashCode ^
        businessname.hashCode ^
        address.hashCode ^
        city.hashCode ^
        pincode.hashCode ^
        state.hashCode ^
        service.hashCode ^
        photoUrl.hashCode;
  }
}
