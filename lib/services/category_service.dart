import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/category.dart';

class CategoryService extends ChangeNotifier {

  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<CategoryList> categories = [];
  CategoryList? selectCategory;
  bool isLoading = true;
  bool isEditCreate = true;
  
  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final providersMap = Category.fromJson(response.body);
    categories = providersMap.list;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(CategoryList category) async {
    isEditCreate = true;
    notifyListeners();
    if (category.categoryId == 0) {
      await createCategory(category);
    } else {
      await updateProvider(category);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProvider(CategoryList category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    final index = categories.indexWhere((element) => element.categoryId == category.categoryId);
    categories[index] = category;

    return '';
  }

  Future createCategory(CategoryList category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    return '';
  }

  Future deleteCategory(CategoryList category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    this.categories.clear();
    loadCategories();
    Navigator.of(context).pushNamed('list');
    return '';
  }
}