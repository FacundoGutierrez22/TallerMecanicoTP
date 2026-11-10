# 🚗 Sistema de Gestión para Taller Mecánico

Este proyecto consiste en el desarrollo de una **Base de Datos relacional para la gestión integral de un Taller Mecánico**, optimizando el control de atención a clientes, reparaciones, asignación de mecánicos e inventario de repuestos.

## 📚 Contexto Académico

Este sistema fue desarrollado en el marco de la materia **Base de Datos 2** de la **Tecnicatura Universitaria en Programación - UTN FRGP**.

### 👥 Integrantes del equipo (Equipo # 30)

- **Gutiérrez, Facundo**
- **Ponce, Alberto Alejandro**

---

## 🧩 Descripción del Sistema

El sistema permite administrar el ciclo de vida completo de una orden de trabajo en el taller:

- **Gestión de Clientes y Vehículos:** Registro de propietarios y vinculación con su flota de vehículos (identificados por patente, marca, modelo, año y kilometraje).
- **Órdenes de Trabajo:** Seguimiento del estado de reparaciones (Pendiente, En Proceso, Esperando Repuestos, Finalizada, Entregada), capturando diagnósticos y kilometraje histórico.
- **Asignación de Personal:** Administración de mecánicos y asignación según su especialidad.
- **Control de Inventario y Proveedores:** Gestión del stock de repuestos, precios unitarios, alertas de stock mínimo y control de proveedores.
- **Trazabilidad e Historiales:** Auditoría de cambios de estado en las órdenes y registro histórico de variaciones de precios en repuestos.

La base de datos gestiona las siguientes entidades principales:

- Clientes
- Vehículos y Marcas
- Mecánicos
- Estados de Orden e Historial de Estados
- Órdenes de Trabajo
- Proveedores, Repuestos e Historial de Precios
- Detalle de Orden (Repuestos consumidos)

---



## 📝 Recomendaciones para la ejecución del Script SQL

- La base de datos debe crearse bajo el nombre `TallerMecanicoDB`.
- Para una correcta ejecución en SQL Server, ejecutar el script completo de manera secuencial respetando las secciones:
  1. Creación de la base de datos y selección (`CREATE DATABASE` / `USE`).
  2. Tablas maestras e independientes.
  3. Tablas relacionales con restricciones `FOREIGN KEY`, `UNIQUE` y `CHECK`.
  4. Inserción de datos de prueba (`INSERT INTO`).
  5. Creación de objetos programables (Vistas, Stored Procedures y Triggers).

---

## Equipo 30 - UTN FRGP