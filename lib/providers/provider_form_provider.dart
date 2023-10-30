import 'package:flutter/material.dart';
import '../models/provider.dart';

class ProviderFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ProviderList provider;
  ProviderFormProvider(this.provider);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}