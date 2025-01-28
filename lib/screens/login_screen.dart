import 'package:flutter/material.dart';
import 'package:inventario_muebleria_byl/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Image
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/Silla_Inicio.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Right side - Login form
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'B&L MUEBLES',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Iniciar Sesión',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    label: 'Correo',
                    isPassword: false,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    label: 'Contraseña',
                    isPassword: true,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Lógica de inicio de sesión
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Continuar'),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navegar a la pantalla de registro
                      },
                      child: Text(
                        '¿Aún no tienes una cuenta? Regístrate',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
