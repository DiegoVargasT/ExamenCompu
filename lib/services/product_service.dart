import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'dart:convert';

class ProductService extends ChangeNotifier {
  final String baseUrl = '143.198.118.203:8000';
  final String user = 'test';
  final String pass = 'test2023';


  List<ProductList> products = [];
  ProductList? selectProduct;
  bool isLoading = true;
  bool isEditCreate = true;
  
  ProductService() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      baseUrl,
      'ejemplos/product_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = Product.fromJson(response.body);
    products = productsMap.list;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(ProductList product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await createProduct(product);
    } else {
      await this.updateProduct(product);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductList product) async {
    final url = Uri.http(
      baseUrl,
      'ejemplos/product_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final index = products.indexWhere((element) => element.productId == product.productId);
    products[index] = product;

    return '';
  }

  Future createProduct(ProductList product) async {
    final url = Uri.http(
      baseUrl,
      'ejemplos/product_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    return '';
  }

  Future deleteProduct(ProductList product, BuildContext context) async {
    final url = Uri.http(
      baseUrl,
      'ejemplos/product_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$user:$pass'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    products.clear();
    loadProducts();
    return '';
  }
}