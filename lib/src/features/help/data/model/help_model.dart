import 'dart:convert';

import 'package:studio_partner_app/src/features/help/domain/entity/help_entity.dart';

class HelpModel extends HelpEntity {
  HelpModel({required super.title, required super.description});

  HelpModel copyWith({
    String? title,
    String? description,
  }) {
    return HelpModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory HelpModel.fromMap(Map<String, dynamic> map) {
    return HelpModel(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HelpModel.fromJson(String source) =>
      HelpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HelpModel(title: $title, description: $description)';

  @override
  bool operator ==(covariant HelpModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
