import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_form_provider.dart';
import '../widgets/card_container.dart';
import '../services/auth_service.dart';
import '../widgets/auth_background.dart';

import '../widgets/inputs_color.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
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
                const Text('Registra nueva cuenta',),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: RegisterForm(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(StadiumBorder())),
                  child: const Text('¿Ya tienes cuenta? Logueate aquí'),
                )
              ])),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {

  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: LoginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputColor.inputDecoration(
              hinText: 'Ingrese correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputColor.inputDecoration(
              hinText: '****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 3)
                  ? null
                  : 'La contraseña no puede estar vacia';
            },
          ),

          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.orange,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(
                'Registrar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            elevation: 0,
            onPressed: LoginForm.loading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    LoginForm.loading = true;
                    final String? errorMessage = await authService.createUser(
                        LoginForm.email, LoginForm.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }
                  },
          )
        ]),
      ),
    );
  }
}