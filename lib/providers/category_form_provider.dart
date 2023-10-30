import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  CategoryList category;
  CategoryFormProvider(this.category);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}