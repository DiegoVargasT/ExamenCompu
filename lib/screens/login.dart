import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/auth_background.dart';
import '../providers/login_form_provider.dart';
import '../services/auth_service.dart';
import '../widgets/card_container.dart';
import '../widgets/inputs_color.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              CardContainer(
                  child: Column(children: [
                const SizedBox(height: 10),
                const Text('Login'),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const LoginForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.blue
                      ),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  child: const Text('¿no tienes una cuenta?, creala aquí'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: LoginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: InputColor.inputDecoration(
            hinText: 'Ingrese su email',
            labelText: 'Email',
            prefixIcon: Icons.email,
          ),
          onChanged: (value) => LoginForm.email = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'El email no puede ser vacio';
          },
        ),

        const SizedBox(height: 40),

        TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: InputColor.inputDecoration(
            hinText: '*******',
            labelText: 'Contraseña',
            prefixIcon: Icons.password,
          ),
          onChanged: (value) => LoginForm.password = value,
          validator: (value) {
            return (value != null && value.length >= 4)
                ? null
                : 'La contraseña no puede ser vacia';
          },

        ),
        const SizedBox(height: 40),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledColor: Colors.grey,
          color: Colors.orange,
          elevation: 0,
          onPressed: LoginForm.loading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final authService = Provider.of<AuthService>(context, listen: false);
                  if (!LoginForm.isValidForm()) return;
                  LoginForm.loading = true;
                  final String? errorMessage = await authService.login(LoginForm.email, LoginForm.password);
                  if (errorMessage == null) {
                    Navigator.pushNamedAndRemoveUntil(context, 'home', (_) => false);
                  }
                  LoginForm.loading = false;
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: const Text(
              'Acceder',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}