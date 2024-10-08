import 'package:flutter/material.dart';

import 'movimientos_screen.dart';
import 'movimientos_service.dart';
import 'transferir_screen.dart';

class HomeScreen extends StatelessWidget {
  final String nombreUsuario;

  HomeScreen({required this.nombreUsuario});

  @override
  Widget build(BuildContext context) {
    double saldo = 1500.0;

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hola, bienvenido $nombreUsuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovimientosScreen(
                            movimientos: MovimientosService().movimientos,
                          ),
                        ),
                      );
                    },
                    child: Text('Movimientos'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferirScreen(),
                        ),
                      );
                    },
                    child: Text('Transferir'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Saldo: \$${saldo.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
