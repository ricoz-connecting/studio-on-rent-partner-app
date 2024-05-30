// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TableEntity {
  final String id;
  final String subject;
  final DateTime createdAt;
  final String status;
  TableEntity({
    required this.id,
    required this.subject,
    required this.createdAt,
    required this.status,
  });

}
