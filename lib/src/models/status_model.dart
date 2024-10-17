import 'dart:convert';

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  final String kycStatus;
  final String membershipStatus;

  Status({
    required this.kycStatus,
    required this.membershipStatus,
  });

  Status copyWith({
    String? kycStatus,
    String? membershipStatus,
  }) =>
      Status(
        kycStatus: kycStatus ?? this.kycStatus,
        membershipStatus: membershipStatus ?? this.membershipStatus,
      );

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        kycStatus: json["kycStatus"] ?? "",
        membershipStatus: json["membershipStatus"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "kycStatus": kycStatus,
        "membershipStatus": membershipStatus,
      };
}
