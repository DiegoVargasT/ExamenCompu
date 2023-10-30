import 'package:flutter/material.dart';
import '../widgets/card.dart';

class HomeScreen extends StatelessWidget {


  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Modulos')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const [
            CardWidget(
              backgroundColor: Colors.green,
              icon: Icons.shopping_cart,
              text: 'Productos',
              route: 'products',
            ),
            CardWidget(
              backgroundColor: Colors.red,
              icon: Icons.folder,
              text: 'Proveedores',
              route: 'providers'),
            CardWidget(
              backgroundColor: Colors.blue,
              icon: Icons.pageview,
              text: 'Categorias',
              route: 'categories',
            )            
          ],
        )
      ),
    );
  }
}