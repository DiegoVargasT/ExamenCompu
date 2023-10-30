import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ProductList product;
  ProductFormProvider(this.product);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}