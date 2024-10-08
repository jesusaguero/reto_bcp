class MovimientosService {
  static final MovimientosService _instance = MovimientosService._internal();
  List<Map<String, dynamic>> _movimientos = [];

  factory MovimientosService() {
    return _instance;
  }

  MovimientosService._internal();

  List<Map<String, dynamic>> get movimientos => _movimientos;

  void agregarMovimiento(Map<String, dynamic> movimiento) {
    _movimientos.add(movimiento);
  }

  void limpiarMovimientos() {
    _movimientos.clear();
  }
}
