import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import '../widgets/category_list_item.dart';
import 'loading.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    
    if (categoryService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            categoryService.selectCategory = categoryService.categories[index].copy();
            Navigator.pushNamed(context, 'categories/crear-editar');
          },
          child: CategoryListItem(category: categoryService.categories[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nueva Categoria',
        onPressed: () {
          categoryService.selectCategory = CategoryList(categoryId: 0, categoryName: '', categoryState: '');
          Navigator.pushNamed(context, 'categories/crear-editar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}