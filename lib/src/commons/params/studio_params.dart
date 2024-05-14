// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudioParams {
  final String name;
  final double rent;
  final String category;
  final String location;
  final String address;
  final String tags;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> agents;
  StudioParams({
    required this.name,
    required this.rent,
    required this.category,
    required this.location,
    required this.address,
    required this.tags,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.agents,
  });

  StudioParams copyWith({
    String? name,
    double? rent,
    String? category,
    String? location,
    String? address,
    String? tags,
    String? description,
    double? latitude,
    double? longitude,
    List<String>? agents,
  }) {
    return StudioParams(
      name: name ?? this.name,
      rent: rent ?? this.rent,
      category: category ?? this.category,
      location: location ?? this.location,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      agents: agents ?? this.agents,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rent': rent,
      'category': category,
      'location': location,
      'address': address,
      'tags': tags,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'agents': agents,
    };
  }

  factory StudioParams.fromMap(Map<String, dynamic> map) {
    return StudioParams(
      name: map['name'] as String,
      rent: map['rent'] as double,
      category: map['category'] as String,
      location: map['location'] as String,
      address: map['address'] as String,
      tags: map['tags'] as String,
      description: map['description'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      agents: List<String>.from((map['agents'] as List<String>),)
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioParams.fromJson(String source) => StudioParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StudioParams(name: $name, rent: $rent, category: $category, location: $location, address: $address, tags: $tags, description: $description, latitude: $latitude, longitude: $longitude, agents: $agents)';
  }

  @override
  bool operator ==(covariant StudioParams other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.rent == rent &&
      other.category == category &&
      other.location == location &&
      other.address == address &&
      other.tags == tags &&
      other.description == description &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      listEquals(other.agents, agents);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      rent.hashCode ^
      category.hashCode ^
      location.hashCode ^
      address.hashCode ^
      tags.hashCode ^
      description.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      agents.hashCode;
  }
}
