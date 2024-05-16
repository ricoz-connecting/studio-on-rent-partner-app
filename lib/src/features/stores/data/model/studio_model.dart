import 'dart:developer';
import 'dart:typed_data';

import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:uuid/uuid.dart';

class StudioModel extends StudioEntity {
  StudioModel(
      {required super.id,
      required super.rent,
      required super.category,
      required super.rating,
      required super.name,
      required super.location,
      required super.address,
      required super.tags,
      required super.description,
      required super.frontImage,
      required super.gallery,
      required super.image,
      required super.latitude,
      required super.longitude,
      required super.agents,
      required super.status});

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    print(map['image']);

    return StudioModel(
      id: map['id'],
      rent: map['rent'],
      category: map['category'],
      rating: map['rating'] ?? 0,
      name: map['name'],
      location: map['location'],
      address: map['address'],
      tags: List<String>.from(map['tags']),
      description: map['description'],
      frontImage: (map['frontImage'] as List)
          .map((e) => Uint8List.fromList(List<int>.from(e['data'])))
          .toList(),

      // List<Uint8List>.from(Uint8List.fromList(map['frontImage']['data'])),
      gallery: (map['gallery'] as List)
          .map((e) => Uint8List.fromList(List<int>.from(e['data'])))
          .toList(),
      image: (Uint8List.fromList(List<int>.from(map['image']['data']))),
      latitude: map['latitude'],
      longitude: map['longitude'],
      agents: List<String>.from(map['agents']),
      status: map['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'rent': rent,
      'category': category,
      'rating': rating,
      'name': name,
      'location': location,
      'address': address,
      'tags': tags,
      'description': description,
      'frontImage': frontImage,
      'gallery': gallery,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'agents': agents,
      'status': status,
    };
  }
}
