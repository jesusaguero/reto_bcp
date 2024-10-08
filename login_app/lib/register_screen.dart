import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_app/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombres = '', apellidos = '', dni = '', sexo = 'M', password = '';
  DateTime? fechaNacimiento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Nombres', (value) => nombres = value),
              _buildTextField('Apellidos', (value) => apellidos = value),
              _buildTextField('DNI', (value) => dni = value),
              _buildPasswordField(),
              _buildSexoDropdown(),
              _buildFechaNacimientoField(),
              ElevatedButton(
                onPressed: _register,
                child: Text('Registrar'),
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

  Widget _buildSexoDropdown() {
    return DropdownButtonFormField<String>(
      value: sexo,
      items: [
        DropdownMenuItem(child: Text('Masculino'), value: 'M'),
        DropdownMenuItem(child: Text('Femenino'), value: 'F'),
      ],
      onChanged: (value) {
        setState(() {
          sexo = value!;
        });
      },
    );
  }

  Widget _buildFechaNacimientoField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
      readOnly: true,
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            fechaNacimiento = picked;
          });
        }
      },
      validator: (value) {
        if (fechaNacimiento == null) return 'Campo requerido';
        int age = DateTime.now().year - fechaNacimiento!.year;
        if (age < 18) return 'Debe ser mayor de 18 años';
        return null;
      },
      controller: TextEditingController(
          text: fechaNacimiento == null
              ? ''
              : DateFormat('yyyy-MM-dd').format(fechaNacimiento!)),
    );
  }

void _register() async {
  if (_formKey.currentState!.validate()) {
    print("Form is valid, attempting to register user.");
    Map<String, dynamic> user = {
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'sexo': sexo,
      'fecha_nacimiento': fechaNacimiento.toString(),
      'password': password,
    };
    
    try {
      int id = await DatabaseHelper().registerUser(user);
      print("User registered with ID: $id");
    
      if (id > 0) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        print("Failed to register user");
      }
    } catch (e) {
      print("Error registering user: $e");
    }
  } else {
    print("Form validation failed");
  }
}

}
