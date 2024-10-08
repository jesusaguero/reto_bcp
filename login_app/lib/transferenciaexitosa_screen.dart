import 'package:flutter/material.dart';

import 'movimientos_screen.dart';
import 'movimientos_service.dart';

class TransferenciaExitosaScreen extends StatelessWidget {
  final double monto;
  final String empresa;
  final DateTime fecha;

  const TransferenciaExitosaScreen({
    Key? key, // Agregar clave opcional
    required this.monto,
    required this.empresa,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferencia Exitosa')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Transferencia de \S/${monto.toStringAsFixed(2)} a $empresa exitosa.'),
            Text('Fecha: ${fecha.toLocal()}'),
            ElevatedButton(
              onPressed: () {
                final nuevoMovimiento = {
                  'monto': monto,
                  'empresa': empresa,
                  'fecha': fecha,
                };
                MovimientosService().agregarMovimiento(nuevoMovimiento);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovimientosScreen(
                      movimientos: MovimientosService().movimientos,
                    ),
                  ),
                );
              },
              child: const Text('Volver a Movimientos'),
            ),
          ],
        ),
      ),
    );
  }
}
