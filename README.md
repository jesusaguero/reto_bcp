# Proyecto de Transferencias y Movimientos

Este proyecto en Flutter es una aplicación que permite realizar transferencias a diferentes empresas y visualizar los movimientos financieros realizados. La aplicación incluye una pantalla de transferencia con cálculo automático de cobros adicionales, y una pantalla de movimientos que muestra los detalles de las transacciones.

## Arquitectura Lógica de Alto Nivel

El proyecto sigue una arquitectura lógica organizada en tres capas principales para una mejor organización y mantenibilidad: **Capa de Presentación**, **Capa de Lógica de Negocio** y **Capa de Datos**.

### 1. Capa de Presentación (UI/UX)

**Objetivo**: Mostrar las pantallas y componentes visuales que interactúan con el usuario.

**Componentes**:
- **Screens**:
  - `TransferirScreen`: Pantalla para iniciar una transferencia.
  - `DetalleTransferenciaScreen`: Pantalla que muestra los detalles de la transferencia.
  - `MovimientosScreen`: Pantalla que muestra la lista de movimientos registrados.
- **Widgets**: Componentes visuales reutilizables como botones, formularios y listas.
- **Navegación**: Navegación entre pantallas utilizando `Navigator`.

### 2. Capa de Lógica de Negocio (Servicios)

**Objetivo**: Manejar las reglas de negocio, la validación de datos y la lógica de la aplicación.

**Componentes**:
- **MovimientosService**: Servicio encargado de gestionar la lista de movimientos financieros. Permite agregar y limpiar movimientos.
- **Transferencia lógica**: Implementa la lógica para realizar las transferencias y aplicar un cobro del 0.2% en transferencias mayores a S/50.

### 3. Capa de Datos (Almacenamiento)

**Objetivo**: Proporcionar acceso a los datos y su persistencia.

**Componentes**:
- **Almacenamiento local**: Actualmente se usa una lista en memoria dentro de `MovimientosService`. Se puede extender a una base de datos local como SQLite para persistencia de datos.
- **Almacenamiento remoto (futuro)**: Se podría conectar con un backend para gestionar las transferencias y movimientos de manera remota.

## Flujo de Datos entre Capas

1. El usuario ingresa el monto y selecciona una empresa para realizar una transferencia.
2. Se valida el monto. Si es mayor a S/50, se aplica un cobro del 0.2%.
3. Se registra el `montoFinal` y se actualiza el historial de movimientos en `MovimientosService`.
4. El usuario puede ver la lista de movimientos en la pantalla `MovimientosScreen`.


## Instalación

1. Clonar el repositorio:
   ```bash
   git clone [https://github.com/jesusaguero/reto_bcp/]
