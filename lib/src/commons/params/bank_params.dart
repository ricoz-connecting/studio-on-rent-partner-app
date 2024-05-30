// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankParams {
  final String bankName;
  final String accountNo;
  final String agentId;
  final String ifscCode;
  final String holderName;
  BankParams({
    required this.bankName,
    required this.accountNo,
    required this.agentId,
    required this.ifscCode,
    required this.holderName,
  });

  BankParams copyWith({
    String? bankName,
    String? accountNo,
    String? agentId,
    String? ifscCode,
    String? holderName,
  }) {
    return BankParams(
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
      agentId: agentId ?? this.agentId,
      ifscCode: ifscCode ?? this.ifscCode,
      holderName: holderName ?? this.holderName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankName': bankName,
      'accountNo': accountNo,
      'agentId': agentId,
      'ifscCode': ifscCode,
      'holderName': holderName,
    };
  }

  factory BankParams.fromMap(Map<String, dynamic> map) {
    return BankParams(
      bankName: map['bankName'] as String,
      accountNo: map['accountNo'] as String,
      agentId: map['agentId'] as String,
      ifscCode: map['ifscCode'] as String,
      holderName: map['holderName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankParams.fromJson(String source) =>
      BankParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankParams(bankName: $bankName, accountNo: $accountNo, agentId: $agentId, ifscCode: $ifscCode, holderName: $holderName)';
  }

  @override
  bool operator ==(covariant BankParams other) {
    if (identical(this, other)) return true;

    return other.bankName == bankName &&
        other.accountNo == accountNo &&
        other.agentId == agentId &&
        other.ifscCode == ifscCode &&
        other.holderName == holderName;
  }

  @override
  int get hashCode {
    return bankName.hashCode ^
        accountNo.hashCode ^
        agentId.hashCode ^
        ifscCode.hashCode ^
        holderName.hashCode;
  }
}

class PaymentParams {
  final String accountNo;
  final String agentId;
  final double amount;
  PaymentParams({
    required this.accountNo,
    required this.agentId,
    required this.amount,
  });

  PaymentParams copyWith({
    String? accountNo,
    String? agentId,
    double? amount,
  }) {
    return PaymentParams(
      accountNo: accountNo ?? this.accountNo,
      agentId: agentId ?? this.agentId,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountNo': accountNo,
      'agentId': agentId,
      'amount': amount,
    };
  }

  factory PaymentParams.fromMap(Map<String, dynamic> map) {
    return PaymentParams(
      accountNo: map['accountNo'] as String,
      agentId: map['agentId'] as String,
      amount: map['amount'] as double,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PaymentParams.fromJson(String source) =>
      PaymentParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaymentParams(accountNo: $accountNo, agentId: $agentId, amount: $amount)';

  @override
  bool operator ==(covariant PaymentParams other) {
    if (identical(this, other)) return true;

    return other.accountNo == accountNo &&
        other.agentId == agentId &&
        other.amount == amount;
  }

  @override
  int get hashCode => accountNo.hashCode ^ agentId.hashCode ^ amount.hashCode;
}
