import 'package:flutter/material.dart';
import 'package:login_app/database_helper.dart';
import 'package:login_app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String dni = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('DNI', (value) => dni = value),
              _buildPasswordField(),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Campo requerido';
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contraseña'),
      obscureText: true,
      onChanged: (value) => password = value,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Campo requerido';
        return null;
      },
    );
  }

void _login() async {
  if (_formKey.currentState!.validate()) {
    var user = await DatabaseHelper().loginUser(dni, password);

    if (user != null) {
      String nombreUsuario = user['nombres'];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(nombreUsuario: nombreUsuario),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }
}

}
