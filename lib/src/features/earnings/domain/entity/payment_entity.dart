// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Earnings {
  final num todaysEarning;
  final num toatalEarning;
  final num allSchdules;
  final num rejectedSchedules;
  final num acceptedSchedules;
  final num pendingSchedules;
  final List<Transactions> transaction;
  Earnings({
    required this.pendingSchedules,
    required this.todaysEarning,
    required this.toatalEarning,
    required this.allSchdules,
    required this.rejectedSchedules,
    required this.acceptedSchedules,
    required this.transaction,
  });

  Earnings copyWith({
    num? todaysEarning,
    num? toatalEarning,
    num? allSchdules,
    num? rejectedSchedules,
    num? acceptedSchedules,
    List<Transactions>? transaction,
  }) {
    return Earnings(pendingSchedules: todaysEarning??this.toatalEarning,
      todaysEarning: todaysEarning ?? this.todaysEarning,
      toatalEarning: toatalEarning ?? this.toatalEarning,
      allSchdules: allSchdules ?? this.allSchdules,
      rejectedSchedules: rejectedSchedules ?? this.rejectedSchedules,
      acceptedSchedules: acceptedSchedules ?? this.acceptedSchedules,
      transaction: transaction ?? this.transaction,
    );
  }

  static Earnings empty() {
    return Earnings(
      pendingSchedules: 22,
        todaysEarning: 22,
        toatalEarning: 22,
        allSchdules: 22,
        rejectedSchedules: 22,
        acceptedSchedules: 22,
        transaction: [
          Transactions(
              id: 'ewq3sd3er3', amount: 'amount', created_at: DateTime.now())
        ]);
  }

  factory Earnings.fromMap(Map<String, dynamic> map) {
    return Earnings(
      pendingSchedules: map['pendind']as num,
      todaysEarning: map['todaysEarning'] as num,
      toatalEarning: map['toatalEarning'] as num,
      allSchdules: map['allSchdules'] as num,
      rejectedSchedules: map['rejectedSchedules'] as num,
      acceptedSchedules: map['acceptedSchedules'] as num,
      transaction: List<Transactions>.from(
        (map['transaction'] as List<int>).map<Transactions>(
          (x) => Transactions.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory Earnings.fromJson(String source) =>
      Earnings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Earnings(todaysEarning: $todaysEarning, toatalEarning: $toatalEarning, allSchdules: $allSchdules, rejectedSchedules: $rejectedSchedules, acceptedSchedules: $acceptedSchedules, transaction: $transaction)';
  }

  @override
  bool operator ==(covariant Earnings other) {
    if (identical(this, other)) return true;

    return other.todaysEarning == todaysEarning &&
        other.toatalEarning == toatalEarning &&
        other.allSchdules == allSchdules &&
        other.rejectedSchedules == rejectedSchedules &&
        other.acceptedSchedules == acceptedSchedules &&
        listEquals(other.transaction, transaction);
  }

  @override
  int get hashCode {
    return todaysEarning.hashCode ^
        toatalEarning.hashCode ^
        allSchdules.hashCode ^
        rejectedSchedules.hashCode ^
        acceptedSchedules.hashCode ^
        transaction.hashCode;
  }
}

class Transactions {
  final String id;
  final String amount;
  final DateTime created_at;

  Transactions({
    required this.id,
    required this.amount,
    required this.created_at,
  });

  Transactions copyWith({
    String? id,
    String? amount,
    DateTime? created_at,
  }) {
    return Transactions(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'created_at': created_at,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: (map['id'] ?? map['_id']) as String,
      amount: (map['amount'] / 100).toString(),
      created_at: DateTime.parse(map['created_at'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions.fromJson(String source) =>
      Transactions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Transactions(id: $id, amount: $amount, created_at: $created_at)';

  @override
  bool operator ==(covariant Transactions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.created_at == created_at;
  }

  @override
  int get hashCode => id.hashCode ^ amount.hashCode ^ created_at.hashCode;
}

class Schedules {
  final String agentId;
  final String status;
  Schedules({
    required this.agentId,
    required this.status,
  });

  Schedules copyWith({
    String? agentId,
    String? status,
  }) {
    return Schedules(
      agentId: agentId ?? this.agentId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agentId': agentId,
      'status': status,
    };
  }

  factory Schedules.fromMap(Map<String, dynamic> map) {
    return Schedules(
      agentId: map['agentId'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedules.fromJson(String source) =>
      Schedules.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Schedules(agentId: $agentId, status: $status)';

  @override
  bool operator ==(covariant Schedules other) {
    if (identical(this, other)) return true;

    return other.agentId == agentId && other.status == status;
  }

  @override
  int get hashCode => agentId.hashCode ^ status.hashCode;
}
