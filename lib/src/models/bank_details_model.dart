import 'dart:convert';

Banks bankDetailsFromJson(String str) =>
    Banks.fromJson(json.decode(str));

String bankDetailsToJson(Banks data) => json.encode(data.toJson());

class Banks {
  final String id;
  final String bankName;
  final String accountNumber;
  final String accountHolderName;
  final String ifscCode;
  final bool primary;

  Banks({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
    required this.ifscCode,
    this.primary = true,
  });
  Banks copyWith({
    String? id,
    String? bankName,
    String? accountNumber,
    String? accountHolderName,
    String? ifscCode,
    bool? primary,
  }) =>
      Banks(
        id: id ?? this.id,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
        accountHolderName: accountHolderName ?? this.accountHolderName,
        ifscCode: ifscCode ?? this.ifscCode,
        primary: primary ?? this.primary,
      );
  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
        id: json['_id'],
        bankName: json['bankName'],
        accountNumber: json['accountNumber'],
        accountHolderName: json['accountHolderName'],
        ifscCode: json['IFSCcode'],
        primary: json['primary'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'accountHolderName': accountHolderName,
        'IFSCcode': ifscCode,
        'primary': primary,
      };
}
