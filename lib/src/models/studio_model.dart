import 'dart:convert';
import 'dart:io';

class Studio {
  final String? id;
  final String? name;
  final String? category;
  final String? type;
  final String? about;
  final List<Price>? price;
  final int? basePricePerHour;
  final int? fullPricePerDay;
  final int? equipmentCharges;
  final int? securityDeposit;
  final int? cleaningCharges;
  final Location? location;
  final String? address;
  final String? city;
  final String? pincode;
  final String? state;
  final String? country;
  final List<String>? images;
  final List<File>? imagesFiles;
  final List<String>? videos;
  final List<File>? videosFiles;
  final File? thumbnailFile;
  final String? thumbnail;
  final List<String>? facility;
  final String? areaSqFt;
  final String? rentOrSell;
  bool? isActive;

  Studio({
    this.id,
    this.name,
    this.type,
    this.category,
    this.about,
    this.price,
    this.basePricePerHour,
    this.fullPricePerDay,
    this.equipmentCharges,
    this.securityDeposit,
    this.cleaningCharges,
    this.location,
    this.address,
    this.city,
    this.pincode,
    this.state,
    this.country,
    this.images,
    this.imagesFiles,
    this.videos,
    this.videosFiles,
    this.thumbnailFile,
    this.thumbnail,
    this.facility,
    this.areaSqFt,
    this.rentOrSell,
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
        basePricePerHour: json['basePricePerHour'],
        fullPricePerDay: json['fullPricePerDay'],
        equipmentCharges: json['equipmentCharges'],
        securityDeposit: json['securityDeposit'],
        cleaningCharges: json['cleaningCharges'],
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        address: json['address'],
        city: json['city'],
        pincode: json['pincode'],
        state: json['state'],
        country: json['country'],
        images: json['images'] != null
            ? List<String>.from(json['images'].map((x) => x))
            : null,
        videos: json['videos'] != null
            ? List<String>.from(json['videos'].map((x) => x))
            : null,
        thumbnail: json['thumbnail'],
        facility: json['facility'] != null
            ? List<String>.from(json['facility'].map((x) => x))
            : null,
        areaSqFt: json['areaSqFt'],
        rentOrSell: json['rentOrSell'],
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
        if (basePricePerHour != null) 'basePricePerHour': basePricePerHour,
        if (fullPricePerDay != null) 'fullPricePerDay': fullPricePerDay,
        if (equipmentCharges != null) 'equipmentCharges': equipmentCharges,
        if (securityDeposit != null) 'securityDeposit': securityDeposit,
        if (cleaningCharges != null) 'cleaningCharges': cleaningCharges,
        if (location!.coordinates!.isNotEmpty) 'location': location?.toJson(),
        if (address != null) 'address': address,
        if (city != null) 'city': city,
        if (pincode != null) 'pincode': pincode,
        if (state != null) 'state': state,
        if (country != null) 'country': country,
        if (images != null)
          'images':
              images != null ? List<dynamic>.from(images!.map((x) => x)) : null,
        if (videos != null)
          'videos':
              videos != null ? List<dynamic>.from(videos!.map((x) => x)) : null,
        if (thumbnail != null) 'thumbnail': thumbnail,
        if (facility != null) 'facility': facility,
        if (areaSqFt != null) 'areaSqFt': areaSqFt,
        if (rentOrSell != null) 'rentOrSell': rentOrSell,
        if (isActive != null) 'isActive': isActive,
      };

  Studio copyWith({
    String? id,
    String? name,
    String? type,
    String? category,
    String? about,
    List<Price>? price,
    int? basePricePerHour,
    int? fullPricePerDay,
    int? equipmentCharges,
    int? securityDeposit,
    int? cleaningCharges,
    Location? location,
    String? address,
    String? city,
    String? pincode,
    String? state,
    String? country,
    List<String>? images,
    List<File>? imagesFiles,
    List<String>? videos,
    List<File>? videosFiles,
    File? thumbnailFile,
    String? thumbnail,
    List<String>? facility,
    String? areaSqFt,
    String? rentOrSell,
    bool? isActive,
  }) {
    return Studio(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      category: category ?? this.category,
      about: about ?? this.about,
      price: price ?? this.price,
      basePricePerHour: basePricePerHour ?? this.basePricePerHour,
      fullPricePerDay: fullPricePerDay ?? this.fullPricePerDay,
      equipmentCharges: equipmentCharges ?? this.equipmentCharges,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      cleaningCharges: cleaningCharges ?? this.cleaningCharges,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      country: country ?? this.country,
      images: images ?? this.images,
      imagesFiles: imagesFiles ?? this.imagesFiles,
      thumbnailFile: thumbnailFile ?? this.thumbnailFile,
      videos: videos ?? this.videos,
      videosFiles: videosFiles ?? this.videosFiles,
      thumbnail: thumbnail ?? this.thumbnail,
      facility: facility ?? this.facility,
      areaSqFt: areaSqFt ?? this.areaSqFt,
      rentOrSell: rentOrSell ?? this.rentOrSell,
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

Studio userFromJson(String str) => Studio.fromJson(json.decode(str));

String userToJson(Studio data) => json.encode(data.toJson());
