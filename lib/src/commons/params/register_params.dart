// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:studio_partner_app/src/utils/functions.dart';

enum DocumentType {
  AdhaarCard,
  PANCard,
}

class RegisterParams {
  final Uint8List photoUrl;
  final String qrData;
  final String description;
  final String name;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String email;
  final String? businessName;
  final String pincode;
  final List<String> services;
  final DocumentType documentType;
  final String documentNumber;
  final Uint8List documentFront;
  final Uint8List documentBack;
  final List<Uint8List> media;

  RegisterParams({
    required this.description,
    required this.qrData,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    this.businessName,
    required this.pincode,
    required this.services,
    required this.documentType,
    required this.documentNumber,
    required this.documentFront,
    required this.documentBack,
    required this.media,
  });

  RegisterParams copyWith({
    Uint8List? photoUrl,
    String? name,
    String? address,
    String? city,
    String? state,
    String? businessName,
    String? pincode,
    List<String>? services,
    DocumentType? documentType,
    String? documentNumber,
    Uint8List? documentFront,
    Uint8List? documentBack,
    String? email,
    String? phoneNumber,
    String? description,
    String? qrData,
    List<Uint8List>? media,
  }) {
    return RegisterParams(
      qrData: qrData ?? this.qrData,
      description: description ?? this.description,
      media: media ?? this.media,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      businessName: businessName ?? this.businessName,
      pincode: pincode ?? this.pincode,
      services: services ?? this.services,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      documentFront: documentFront ?? this.documentFront,
      documentBack: documentBack ?? this.documentBack,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'photoUrl': photoUrl.toList(),
      'email': email,
      'phoneNumber': phoneNumber,
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'businessName': businessName,
      'pincode': pincode,
      'services': services,
      'documentType': documentType.toString().split('.').last,
      'documentNumber': documentNumber,
      'description': description,
      'qrData': qrData
      // 'documentFront': documentFront.toList(),
      // 'documentBack': documentBack.toList(),
      // 'media':media.map((e)=> e.toString()).toList()
    };
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    log(map['services'].toString());
    return RegisterParams(
        description: map['description'],
        qrData: map['qrData'],
        phoneNumber: map["phoneNumber"] as String,
        email: map['email'] as String,
        photoUrl: Uint8List.fromList(map['photoUrl'] as List<int>),
        name: map['name'] as String,
        address: map['address'] as String,
        city: map['city'] as String,
        state: map['state'] as String,
        businessName:
            map['businessName'] != null ? map['businessName'] as String : null,
        pincode: map['pincode'] as String,
        services: (map['services'] as List<String>),
        documentType: stringToEnum(map['documentType'] as String),
        documentNumber: map['documentNumber'] as String,
        documentFront: Uint8List.fromList(map['photoUrl'] as List<int>),
        documentBack: Uint8List.fromList(map['photoUrl'] as List<int>),
        media: map['media'] as List<Uint8List>);
  }

  String toJson() => json.encode(toMap());

  factory RegisterParams.fromJson(String source) =>
      RegisterParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterParams(photoUrl: $photoUrl, name: $name, address: $address, city: $city, state: $state, businessName: $businessName, pincode: $pincode, services: $services, documentType: $documentType, documentNumber: $documentNumber, documentFront: $documentFront, documentBack: $documentBack)';
  }

  @override
  bool operator ==(covariant RegisterParams other) {
    if (identical(this, other)) return true;

    return other.photoUrl == photoUrl &&
        other.name == name &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.businessName == businessName &&
        other.pincode == pincode &&
        listEquals(other.services, services) &&
        other.documentType == documentType &&
        other.documentNumber == documentNumber &&
        other.documentFront == documentFront &&
        other.documentBack == documentBack;
  }

  @override
  int get hashCode {
    return photoUrl.hashCode ^
        name.hashCode ^
        address.hashCode ^
        city.hashCode ^
        state.hashCode ^
        businessName.hashCode ^
        pincode.hashCode ^
        services.hashCode ^
        documentType.hashCode ^
        documentNumber.hashCode ^
        documentFront.hashCode ^
        documentBack.hashCode;
  }
}
