// To parse this JSON data, do
//
//     final reviewsModel = reviewsModelFromJson(jsonString);

import 'dart:convert';

ReviewsModel reviewsModelFromJson(String str) =>
    ReviewsModel.fromJson(json.decode(str));

String reviewsModelToJson(ReviewsModel data) => json.encode(data.toJson());

class ReviewsModel {
  final String? id;
  final String? businessProfileDocId;
  final String? userDocId;
  final String? customerName;
  final String? customerProfiles;
  final String? feedback;
  final List<String>? images;
  final double? rating;
  final int? v;

  ReviewsModel({
    this.id,
    this.businessProfileDocId,
    this.userDocId,
    this.customerName,
    this.customerProfiles,
    this.feedback,
    this.images,
    this.rating,
    this.v,
  });

  ReviewsModel copyWith({
    String? id,
    String? businessProfileDocId,
    String? userDocId,
    String? customerName,
    String? customerProfiles,
    String? feedback,
    List<String>? images,
    double? rating,
    int? v,
  }) =>
      ReviewsModel(
        id: id ?? this.id,
        businessProfileDocId: businessProfileDocId ?? this.businessProfileDocId,
        userDocId: userDocId ?? this.userDocId,
        customerName: customerName ?? this.customerName,
        customerProfiles: customerProfiles ?? this.customerProfiles,
        feedback: feedback ?? this.feedback,
        images: images ?? this.images,
        rating: rating ?? this.rating,
        v: v ?? this.v,
      );

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        id: json["_id"],
        businessProfileDocId: json["businessProfileDocId"],
        userDocId: json["userDocId"],
        customerName: json["customerName"],
        customerProfiles: json["customerProfiles"],
        feedback: json["feedback"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        rating: json["rating"]?.toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "businessProfileDocId": businessProfileDocId,
        "userDocId": userDocId,
        "customerName": customerName,
        "customerProfiles": customerProfiles,
        "feedback": feedback,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "rating": rating,
        "__v": v,
      };
}
