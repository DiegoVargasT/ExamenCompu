import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}