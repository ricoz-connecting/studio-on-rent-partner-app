import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.title});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {"id": id, "title": title};
  }
}
