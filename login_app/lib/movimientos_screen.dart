import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovimientosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> movimientos;

  MovimientosScreen({required this.movimientos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movimientos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: movimientos.isEmpty
                  ? Center(child: Text('No hay movimientos registrados.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Monto')),
                          DataColumn(label: Text('Empresa')),
                          DataColumn(label: Text('Fecha')),
                          DataColumn(label: Text('Monto Final')),
                        ],
                        rows: movimientos.map((movimiento) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text('\S/${movimiento['monto'].toStringAsFixed(2)}')),
                              DataCell(Text(movimiento['empresa'])),
                              DataCell(Text(DateFormat('dd/MM/yyyy HH:mm').format(movimiento['fecha']))),
                              DataCell(Text('\S/${movimiento['montoFinal'].toStringAsFixed(2)}')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('Regresar al Home'),
            ),
          ],
        ),
      ),
    );
  }
}
