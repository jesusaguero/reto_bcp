import 'package:flutter/material.dart';
import 'package:login_app/home_screen.dart';
import 'package:login_app/login_screen.dart';
import 'package:login_app/movimientos_screen.dart';
import 'package:login_app/register_screen.dart';
import 'package:login_app/transferir_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart' as sqflite_web;


void main() {
  if (isWeb) {
    databaseFactory = sqflite_web.databaseFactoryFfiWeb;
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }  runApp(MyApp());
}
bool get isWeb => identical(0, 0.0);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(nombreUsuario: '',),
        '/movimientos': (context) => MovimientosScreen(movimientos: []),
        '/transferir': (context) => TransferirScreen(),
      },
    );
  }
}

