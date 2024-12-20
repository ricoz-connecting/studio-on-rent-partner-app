import 'dart:convert';

StudioReviewsModel studioReviewsModelFromJson(String str) =>
    StudioReviewsModel.fromJson(json.decode(str));

String studioReviewsModelToJson(StudioReviewsModel data) =>
    json.encode(data.toJson());

class StudioReviewsModel {
  final String id;
  final String name;
  final String thumbnail;
  final String rentOrSell;
  final int totalRatings;
  final double averageRating;

  StudioReviewsModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.rentOrSell,
    required this.totalRatings,
    required this.averageRating,
  });

  StudioReviewsModel copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? rentOrSell,
    int? totalRatings,
    double? averageRating,
  }) =>
      StudioReviewsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        thumbnail: thumbnail ?? this.thumbnail,
        rentOrSell: rentOrSell ?? this.rentOrSell,
        totalRatings: totalRatings ?? this.totalRatings,
        averageRating: averageRating ?? this.averageRating,
      );

  factory StudioReviewsModel.fromJson(Map<String, dynamic> json) =>
      StudioReviewsModel(
        id: json["_id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        rentOrSell: json["rentOrSell"],
        totalRatings: json["totalRatings"],
        averageRating: json["averageRating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "thumbnail": thumbnail,
        "rentOrSell": rentOrSell,
        "totalRatings": totalRatings,
        "averageRating": averageRating,
      };
}
