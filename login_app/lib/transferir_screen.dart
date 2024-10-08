import 'package:flutter/material.dart';

import 'movimientos_screen.dart';
import 'movimientos_service.dart';

class TransferirScreen extends StatefulWidget {
  @override
  _TransferirScreenState createState() => _TransferirScreenState();
}

class _TransferirScreenState extends State<TransferirScreen> {
  final List<String> empresas = ['Movistar', 'Tecsup', 'Oncosalud'];
  double monto = 0.0;
  final TextEditingController _montoController = TextEditingController();

  void realizarTransferencia(String empresa) {
    double cobro = 0.0;

    if (monto > 50) {
      cobro = monto * 0.002;
    }

    double montoFinal = monto + cobro;

    final nuevoMovimiento = {
      'monto': monto,
      'empresa': empresa,
      'fecha': DateTime.now(),
      'cobro': cobro,
      'montoFinal': montoFinal,
    };
    MovimientosService().agregarMovimiento(nuevoMovimiento);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transferencia Exitosa'),
          content: Text('Se ha transferido S/${monto.toStringAsFixed(2)} a $empresa.\nCobro: S/${cobro.toStringAsFixed(2)}\nMonto final: S/${montoFinal.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovimientosScreen(movimientos: MovimientosService().movimientos),
                  ),
                );
              },
              child: Text('Ver Movimientos'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferir')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _montoController,
              decoration: InputDecoration(
                labelText: 'Monto a transferir (S/)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  monto = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: empresas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(empresas[index]),
                  onTap: () {
                    if (monto > 0) {
                      realizarTransferencia(empresas[index]);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Por favor ingrese un monto válido.')),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.transfer_within_a_station),
        onPressed: () {
        },
      ),
    );
  }
}
