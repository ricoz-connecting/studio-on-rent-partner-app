import 'dart:convert';
import 'dart:io';

KYC userFromJson(String str) => KYC.fromJson(json.decode(str));

String userToJson(KYC data) => json.encode(data.toJson());

class KYC {
  final String? nameOnDocument;
  final String? documentType;
  final String? documentNumber;
  final String? frontImage;
  final File? frontFile;
  final String? backImage;
  final File? backFile;

  KYC({
    this.nameOnDocument,
    this.documentType,
    this.documentNumber,
    this.frontImage,
    this.frontFile,
    this.backImage,
    this.backFile,
  });

  KYC copyWith({
    String? nameOnDocument,
    String? documentType,
    String? documentNumber,
    String? frontImage,
    File? frontFile,
    String? backImage,
    File? backFile,
  }) =>
      KYC(
        nameOnDocument: nameOnDocument ?? this.nameOnDocument,
        documentType: documentType ?? this.documentType,
        documentNumber: documentNumber ?? this.documentNumber,
        frontImage: frontImage ?? this.frontImage,
        frontFile: frontFile ?? this.frontFile,
        backImage: backImage ?? this.backImage,
        backFile: backFile ?? this.backFile,
      );

  factory KYC.fromJson(Map<String, dynamic> json) => KYC(
        nameOnDocument: json["nameOnDocument"],
        documentType: json["documentType"],
        documentNumber: json["documentNumber"],
        frontImage: json["frontImage"],
        backImage: json["backImage"],
      );

  Map<String, dynamic> toJson() => {
        "nameOnDocument": nameOnDocument,
        "documentType": documentType,
        "documentNumber": documentNumber,
        "frontImage": frontImage,
        "backImage": backImage,
      };
}
