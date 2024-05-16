// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class StudioEntity {
   final String id;
  final num rent;
  final String category;
  final num rating;
  final String name;
  final String location;
  final String address;
  final List<String> tags;
  final String description;
  final List<Uint8List> frontImage;
  final List<Uint8List> gallery;
  final Uint8List image;
  final double latitude;
  final double longitude;
  final List<String> agents;
  final String status;
  StudioEntity({
    required this.id,
    required this.rent,
    required this.category,
    required this.rating,
    required this.name,
    required this.location,
    required this.address,
    required this.tags,
    required this.description,
    required this.frontImage,
    required this.gallery,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.agents,
    required this.status,
  });

  StudioEntity copyWith({
    String? id,
    num? rent,
    String? category,
    double? rating,
    String? name,
    String? location,
    String? address,
    List<String>? tags,
    String? description,
    List<Uint8List>? frontImage,
    List<Uint8List>? gallery,
    Uint8List? image,
    double? latitude,
    double? longitude,
    List<String>? agents,
    String? status,
  }) {
    return StudioEntity(
      id: id ?? this.id,
      rent: rent ?? this.rent,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      name: name ?? this.name,
      location: location ?? this.location,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      frontImage: frontImage ?? this.frontImage,
      gallery: gallery ?? this.gallery,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      agents: agents ?? this.agents,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rent': rent,
      'category': category,
      'rating': rating,
      'name': name,
      'location': location,
      'address': address,
      'tags': tags,
      'description': description,
     
      'latitude': latitude,
      'longitude': longitude,
      'agents': agents,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'StudioEntity(id: $id, rent: $rent, category: $category, rating: $rating, name: $name, location: $location, address: $address, tags: $tags, description: $description, frontImage: $frontImage, gallery: $gallery, image: $image, latitude: $latitude, longitude: $longitude, agents: $agents, status: $status)';
  }

  @override
  bool operator ==(covariant StudioEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.rent == rent &&
      other.category == category &&
      other.rating == rating &&
      other.name == name &&
      other.location == location &&
      other.address == address &&
      listEquals(other.tags, tags) &&
      other.description == description &&
      listEquals(other.frontImage, frontImage) &&
      listEquals(other.gallery, gallery) &&
      other.image == image &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      listEquals(other.agents, agents) &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      rent.hashCode ^
      category.hashCode ^
      rating.hashCode ^
      name.hashCode ^
      location.hashCode ^
      address.hashCode ^
      tags.hashCode ^
      description.hashCode ^
      frontImage.hashCode ^
      gallery.hashCode ^
      image.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      agents.hashCode ^
      status.hashCode;
  }
}
