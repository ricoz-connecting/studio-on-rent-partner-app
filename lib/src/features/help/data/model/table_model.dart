import 'dart:convert';

import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';

class TableModel extends TableEntity {
  TableModel(
      {required super.id,
      required super.subject,
      required super.createdAt,
      required super.status});

  TableEntity copyWith({
    String? id,
    String? subject,
    DateTime? createdAt,
    String? status,
  }) {
    return TableEntity(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subject': subject,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['_id'] as String,
      subject: map['subject'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TableEntity(id: $id, subject: $subject, createdAt: $createdAt, status: $status)';
  }

  @override
  bool operator ==(covariant TableEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subject == subject &&
        other.createdAt == createdAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subject.hashCode ^
        createdAt.hashCode ^
        status.hashCode;
  }
}
