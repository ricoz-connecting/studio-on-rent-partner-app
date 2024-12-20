import 'dart:convert';

PreviousComplaintModel previousComplaintModelFromJson(String str) =>
    PreviousComplaintModel.fromJson(json.decode(str));

String previousComplaintModelToJson(PreviousComplaintModel data) => json.encode(data.toJson());

class PreviousComplaintModel {
  final String? id;
  final String? complaintID;
  final String? subject;
  final String? description;
  final String? image;
  final String? status;
  final String? partnerDocId;
  final String? userDocId;
  final DateTime? createdAt;
  final int? v;

  PreviousComplaintModel({
    this.id,
    this.complaintID,
    this.subject,
    this.description,
    this.image,
    this.status,
    this.partnerDocId,
    this.userDocId,
    this.createdAt,
    this.v,
  });

  PreviousComplaintModel copyWith({
    String? id,
    String? complaintID,
    String? subject,
    String? description,
    String? image,
    String? status,
    String? partnerDocId,
    String? userDocId,
    DateTime? createdAt,
    int? v,
  }) =>
      PreviousComplaintModel(
        id: id ?? this.id,
        complaintID: complaintID ?? this.complaintID,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        image: image ?? this.image,
        status: status ?? this.status,
        partnerDocId: partnerDocId ?? this.partnerDocId,
        userDocId: userDocId ?? this.userDocId,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory PreviousComplaintModel.fromJson(Map<String, dynamic> json) => PreviousComplaintModel(
        id: json["_id"],
        complaintID: json["complaintID"],
        subject: json["subject"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        partnerDocId: json["partnerDocId"],
        userDocId: json["userDocId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "complaintID": complaintID,
        "subject": subject,
        "description": description,
        "image": image,
        "status": status,
        "partnerDocId": partnerDocId,
        "userDocId": userDocId,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
