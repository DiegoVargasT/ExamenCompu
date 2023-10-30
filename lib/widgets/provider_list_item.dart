import 'package:flutter/material.dart';
import '../models/provider.dart';

class ProviderListItem extends StatelessWidget {
  
  final ProviderList proveedor;
  const ProviderListItem({Key? key, required this.proveedor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${proveedor.providerName} ${proveedor.providerLastName}"),
      subtitle: Text("Estado: ${proveedor.providerState}"),
    );
  }
}