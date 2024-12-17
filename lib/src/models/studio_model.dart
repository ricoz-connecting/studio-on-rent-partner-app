import 'dart:convert';
import 'dart:io';

class Studio {
  final String? id;
  final String? name;
  final String? category;
  final String? type;
  final String? about;
  final List<Price>? price;
  final Location? location;
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;
  // final List<Room>? rooms;
  final List<String>? images;
  final List<File>? imagesFiles;
  final File? thumbnailFile;
  final String? thumbnail;
  final List<String>? facility;
  // final List<NearestFacility>? nearestFacility;
  final String? areaSqFt;
  final String? rentOrSell;
  // final bool? isCouponApplicable;
  bool? isActive;

  Studio({
    this.id,
    this.name,
    this.type,
    this.category,
    this.about,
    this.price,
    this.location,
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
    // this.rooms,
    this.images,
    this.imagesFiles,
    this.thumbnailFile,
    this.thumbnail,
    this.facility,
    // this.nearestFacility,
    this.areaSqFt,
    this.rentOrSell,
    // this.isCouponApplicable,
    this.isActive,
  });

  factory Studio.fromJson(Map<String, dynamic> json) => Studio(
        id: json['_id'],
        name: json['name'],
        type: json['type'],
        category: json['category'],
        about: json['about'],
        price: json['price'] != null
            ? List<Price>.from(json['price'].map((x) => Price.fromJson(x)))
            : null,
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        address: json['address'],
        city: json['city'],
        pincode: json['pincode'],
        state: json['state'],
        country: json['country'],
        // rooms: json['rooms'] != null
        //     ? List<Room>.from(json['rooms'].map((x) => Room.fromJson(x)))
        //     : null,
        images: json['images'] != null
            ? List<String>.from(json['images'].map((x) => x))
            : null,
        thumbnail: json['thumbnail'],
        facility: json['facility'] != null
            ? List<String>.from(json['facility'].map((x) => x))
            : null,
        // nearestFacility: json['nearestFacility'] != null
        //     ? List<NearestFacility>.from(
        //         json['nearestFacility'].map((x) => NearestFacility.fromJson(x)))
        //     : null,
        areaSqFt: json['areaSqFt'],
        rentOrSell: json['rentOrSell'],
        // isCouponApplicable: json['isCouponApplicable'] ?? false,
        isActive: json['isActive'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) '_id': id,
        if (name != null) 'name': name,
        if (type != null) 'type': type,
        if (category != null) 'category': category,
        if (about != null) 'about': about,
        if (price != null)
          'price': price != null
              ? List<dynamic>.from(price!.map((x) => x.toJson()))
              : null,
        if (location!.coordinates!.isNotEmpty) 'location': location?.toJson(),
        if (address != null) 'address': address,
        if (city != null) 'city': city,
        if (pincode != null) 'pincode': pincode,
        if (state != null) 'state': state,
        if (country != null) 'country': country,
        // 'rooms': rooms != null
        //     ? List<dynamic>.from(rooms!.map((x) => x.toJson()))
        //     : null,
        if (images != null)
          'images':
              images != null ? List<dynamic>.from(images!.map((x) => x)) : null,
        if (thumbnail != null) 'thumbnail': thumbnail,
        if (facility != null) 'facility': facility,

        // facility != null
        //     ? List<String>.from(facility!.map((x) => x.toJson()))
        //     : null,
        // 'nearestFacility': nearestFacility != null
        //     ? List<dynamic>.from(nearestFacility!.map((x) => x.toJson()))
        //     : null,
        if (areaSqFt != null) 'areaSqFt': areaSqFt,
        if (rentOrSell != null) 'rentOrSell': rentOrSell,
        // 'isCouponApplicable': isCouponApplicable,
        if (isActive != null) 'isActive': isActive,
      };

  // copyWith method to create a new instance with updated values
  Studio copyWith({
    String? id,
    String? name,
    String? type,
    String? category,
    String? about,
    List<Price>? price,
    Location? location,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
    // List<Room>? rooms,
    List<String>? images,
    List<File>? imagesFiles,
    File? thumbnailFile,
    String? thumbnail,
    List<String>? facility,
    // List<NearestFacility>? nearestFacility,
    String? areaSqFt,
    String? rentOrSell,
    // bool? isCouponApplicable,
    bool? isActive,
  }) {
    return Studio(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      about: about ?? this.about,
      price: price ?? this.price,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      country: country ?? this.country,
      // rooms: rooms ?? this.rooms,
      images: images ?? this.images,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      thumbnail: thumbnail ?? this.thumbnail,
      facility: facility ?? this.facility,
      // nearestFacility: nearestFacility ?? this.nearestFacility,
      areaSqFt: areaSqFt ?? this.areaSqFt,
      rentOrSell: rentOrSell ?? this.rentOrSell,
      // isCouponApplicable: isCouponApplicable ?? this.isCouponApplicable,
      isActive: isActive ?? this.isActive,
    );
  }
}

class Price {
  final String? title;
  final int? amount;
  final int? discount;

  Price({this.title, this.amount, this.discount});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        title: json['title'],
        amount: json['amount'],
        discount: json['discount'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        'discount': discount,
      };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json['type'],
        coordinates: json['coordinates'] != null
            ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates != null
            ? List<dynamic>.from(coordinates!.map((x) => x))
            : null,
      };
}

// class Room {
//   final String? name;
//   int? units;

//   Room({this.name, this.units});

//   factory Room.fromJson(Map<String, dynamic> json) => Room(
//         name: json['name'],
//         units: json['units'],
//       );

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'units': units,
//       };
// }

// class Facility {
//   final String? icon;
//   final String? name;
//   final String? value;

//   Facility({this.icon, this.name, this.value});

//   factory Facility.fromJson(Map<String, dynamic> json) => Facility(
//         icon: json['icon'],
//         name: json['name'],
//         value: json['value'],
//       );

//   Map<String, dynamic> toJson() => {
//         'icon': icon,
//         'name': name,
//         'value': value,
//       };
// }

// class NearestFacility {
//   final String? icon;
//   final String? name;
//   final String? value;

//   NearestFacility({this.icon, this.name, this.value});

//   factory NearestFacility.fromJson(Map<String, dynamic> json) =>
//       NearestFacility(
//         icon: json['icon'],
//         name: json['name'],
//         value: json['value'],
//       );

//   Map<String, dynamic> toJson() => {
//         'icon': icon,
//         'name': name,
//         'value': value,
//       };
// }

// Functions to use the fromJson and toJson methods
Studio userFromJson(String str) => Studio.fromJson(json.decode(str));

String userToJson(Studio data) => json.encode(data.toJson());
