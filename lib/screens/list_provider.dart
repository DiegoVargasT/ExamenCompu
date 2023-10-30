import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import '../models/provider.dart';
import '../services/provider_service.dart';
import '../widgets/provider_list_item.dart';
import 'loading.dart';

class ListProviderScreen extends StatelessWidget {
  const ListProviderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final providerService = prov.Provider.of<ProviderService>(context);
    if (providerService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: ListView.builder(
        itemCount: providerService.providers.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            providerService.selectProvider = providerService.providers[index].copy();
            Navigator.pushNamed(context, 'providers/crear-editar');
          },
          child: ProviderListItem(proveedor: providerService.providers[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear Proveedor",
        onPressed: () {
          providerService.selectProvider = ProviderList(
              providerId: 0,
              providerName: '',
              providerLastName: '',
              providerEmail: '',
              providerState: '');
          Navigator.pushNamed(context, 'providers/crear-editar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}