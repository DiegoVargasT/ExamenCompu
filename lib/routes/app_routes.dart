import 'package:flutter/material.dart';
import '../screens/list_category.dart';
import '../screens/list_product.dart';
import '../screens/list_provider.dart';
import '../screens/create_category.dart';
import '../screens/create_product.dart';
import '../screens/create_provider.dart';
import '../screens/home.dart';
import '../screens/error.dart';
import '../screens/login.dart';
import '../screens/register.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'register': (BuildContext context) => const SignupScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'products': (BuildContext context) => const ListProductScreen(),
    'products/crear-editar': (BuildContext context) => const CreateProductScreen(),
    'categories': (BuildContext context) => const ListCategoryScreen(),
    'categories/crear-editar': (BuildContext context) => const CreateCategoryScreen(),
    'providers': (BuildContext context) => const ListProviderScreen(),
    'providers/crear-editar': (BuildContext context) => const CreateProviderScreen(),

  };
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}