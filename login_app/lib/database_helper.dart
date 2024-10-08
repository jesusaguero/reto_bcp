import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app.db'); // Cambié el nombre del archivo de base de datos
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombres TEXT,
      apellidos TEXT,
      dni TEXT,
      sexo TEXT,
      fecha_nacimiento TEXT,
      password TEXT
    )
    ''');

    // Crear la tabla de movimientos
    await db.execute('''
    CREATE TABLE movimientos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      monto REAL,
      empresa TEXT,
      fecha TEXT
    )
    ''');
  }

  // Método para insertar un usuario
  Future<int> registerUser(Map<String, dynamic> user) async {
    Database db = await database;
    try {
      int result = await db.insert('users', user);
      print("User inserted with id: $result");
      return result;
    } catch (e) {
      print("Error inserting user: $e");
      return -1;
    }
  }

  // Método para login de usuarios
  Future<Map<String, dynamic>?> loginUser(String dni, String password) async {
    Database db = await database;
    List<Map<dynamic, dynamic>> result = await db.query(
      'users',
      where: 'dni = ? AND password = ?',
      whereArgs: [dni, password],
    );

    if (result.isNotEmpty) {
      return result.first.cast<String, dynamic>();
    }
    return null;
  }

  // Métodos para la tabla de movimientos

  // Insertar un movimiento
  Future<int> insertarMovimiento(Map<String, dynamic> movimiento) async {
    Database db = await database;
    try {
      int result = await db.insert('movimientos', movimiento);
      print("Movimiento insertado con id: $result");
      return result;
    } catch (e) {
      print("Error insertando movimiento: $e");
      return -1;
    }
  }

  // Obtener todos los movimientos
  Future<List<Map<String, dynamic>>> obtenerMovimientos() async {
    Database db = await database;
    try {
      List<Map<String, dynamic>> result = await db.query('movimientos');
      return result;
    } catch (e) {
      print("Error obteniendo movimientos: $e");
      return [];
    }
  }
}
