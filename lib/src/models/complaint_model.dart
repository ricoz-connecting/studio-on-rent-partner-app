import 'dart:convert';

Complaint complaintFromJson(String str) => Complaint.fromJson(json.decode(str));

String complaintToJson(Complaint data) => json.encode(data.toJson());

class Complaint {
  final String? id;
  final String? complaintId;
  final String? subject;
  final String? description;
  final String? image;
  final String? status;
  final String? email;
  final String? adminReply;
  final DateTime? adminReplyAt;
  final DateTime? createdAt;
  final int? v;

  Complaint({
    this.id,
    this.complaintId,
    this.subject,
    this.description,
    this.image,
    this.status,
    this.email,
    this.adminReply,
    this.adminReplyAt,
    this.createdAt,
    this.v,
  });

  Complaint copyWith({
    String? id,
    String? complaintId,
    String? subject,
    String? description,
    String? image,
    String? status,
    String? email,
    String? adminReply,
    DateTime? adminReplyAt,
    DateTime? createdAt,
    int? v,
  }) =>
      Complaint(
        id: id ?? this.id,
        complaintId: complaintId ?? this.complaintId,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        image: image ?? this.image,
        status: status ?? this.status,
        email: email ?? this.email,
        adminReply: adminReply ?? this.adminReply,
        adminReplyAt: adminReplyAt ?? this.adminReplyAt,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json["_id"],
        complaintId: json["complaintID"],
        subject: json["subject"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        email: json["email"],
        adminReply: json["adminReply"],
        adminReplyAt: json["adminReplyAt"] == null
            ? null
            : DateTime.parse(json["adminReplyAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "complaintID": complaintId,
        "subject": subject,
        "description": description,
        "image": image,
        "status": status,
        "email": email,
        "adminReply": adminReply,
        "adminReplyAt": adminReplyAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
