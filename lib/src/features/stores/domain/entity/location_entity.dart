// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationEntity {
    final String location;
  final double latitude;
  final double longitude;
  LocationEntity({
    required this.location,
    required this.latitude,
    required this.longitude,
  });
  


  LocationEntity copyWith({
    String? location,
    double? latitude,
    double? longitude,
  }) {
    return LocationEntity(
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationEntity.fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      location: map['location'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationEntity.fromJson(String source) => LocationEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationEntity(location: $location, latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant LocationEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.location == location &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode => location.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}
