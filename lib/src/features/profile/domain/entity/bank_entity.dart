// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankEntity {
  final String bankName;
  final String ifscCode;
  final String accountNo;
  final String agentId;
  BankEntity({
    required this.bankName,
    required this.ifscCode,
    required this.accountNo,
    required this.agentId,
  });


  BankEntity copyWith({
    String? bankName,
    String? ifscCode,
    String? accountNo,
    String? agentId,
  }) {
    return BankEntity(
      bankName: bankName ?? this.bankName,
      ifscCode: ifscCode ?? this.ifscCode,
      accountNo: accountNo ?? this.accountNo,
      agentId: agentId ?? this.agentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'ifscCode': ifscCode,
      'accountNo': accountNo,
      'agentId': agentId,
    };
  }

  factory BankEntity.fromMap(Map<String, dynamic> map) {
    return BankEntity(
      bankName: map['bankName'] as String,
      ifscCode: map['ifscCode'] as String,
      accountNo: map['accountNo'] as String,
      agentId: map['agentId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankEntity.fromJson(String source) => BankEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankEntity(bankName: $bankName, ifscCode: $ifscCode, accountNo: $accountNo, agentId: $agentId)';
  }

  @override
  bool operator ==(covariant BankEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.bankName == bankName &&
      other.ifscCode == ifscCode &&
      other.accountNo == accountNo &&
      other.agentId == agentId;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^
      ifscCode.hashCode ^
      accountNo.hashCode ^
      agentId.hashCode;
  }
}
