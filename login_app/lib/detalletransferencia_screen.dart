import 'package:flutter/material.dart';
import 'package:login_app/database_helper.dart';
import 'package:login_app/transferenciaexitosa_screen.dart';

class DetalleTransferenciaScreen extends StatelessWidget {
  final String empresa;
  final TextEditingController montoController = TextEditingController();

  DetalleTransferenciaScreen({required this.empresa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferir a $empresa')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: montoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto a transferir'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                double monto = double.tryParse(montoController.text) ?? 0;
                DateTime fecha = DateTime.now();

                final nuevoMovimiento = {
                  'monto': monto,
                  'empresa': empresa,
                  'fecha': fecha.toIso8601String(),
                };

                await DatabaseHelper().insertarMovimiento(nuevoMovimiento);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransferenciaExitosaScreen(
                      monto: monto,
                      empresa: empresa,
                      fecha: fecha,
                    ),
                  ),
                );
              },
              child: Text('TRANSFERIR'),
            ),
          ],
        ),
      ),
    );
  }
}
