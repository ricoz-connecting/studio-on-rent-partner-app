import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';

class BankModel extends BankEntity {
  BankModel(
      {required super.bankName,
      required super.ifscCode,
      required super.accountNo,
      required super.agentId});
  factory BankModel.fromMap(map) {
    return BankModel(
        accountNo: map['accountNo'],
        ifscCode: map['ifscCode'],
        agentId: map['agentId'],
        bankName: map['bankName']);
  }
}
