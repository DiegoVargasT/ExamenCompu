import 'dart:convert';

class Category {
  Category({
    required this.list
  });

  List<CategoryList> list;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    list: List<CategoryList>.from(json["Listado Categorias"].map((x) => CategoryList.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Listado Categorias": List<dynamic>.from(list.map((x) => x.toMap())),
  };
}

class CategoryList {
  CategoryList({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory CategoryList.fromJson(String str) => CategoryList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryList.fromMap(Map<String, dynamic> json) => CategoryList(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    categoryState: json["category_state"]
  );

  Map<String, dynamic> toMap() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_state": categoryState
  };

  CategoryList copy() => CategoryList(
      categoryId: categoryId,
      categoryName: categoryName,
      categoryState: categoryState
  );
}