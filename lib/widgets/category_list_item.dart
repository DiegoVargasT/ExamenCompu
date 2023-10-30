import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryList category;
  const CategoryListItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.categoryName),
      subtitle: Text("Estado: ${category.categoryState}"),
    );
  }
}