🚗 Sistema de Gestión para Taller Mecánico

Este proyecto consiste en el desarrollo de una Base de Datos relacional para la gestión integral de un Taller Mecánico, optimizando el control de atención a clientes, órdenes de reparación, asignación de mecánicos e inventario de repuestos.

📚 Contexto Académico

Este sistema fue desarrollado en el marco de la materia Base de Datos 2 de la Tecnicatura Universitaria en Programación - UTN FRGP.

👥 Integrantes del equipo (Grupo 30)

Gutiérrez, Facundo

Ponce, Alberto Alejandro

🧩 Descripción del Sistema

El sistema permite administrar el ciclo de vida completo de una orden de trabajo en el taller:

Gestión de Clientes y Vehículos: Registro de propietarios (con soporte para baja lógica) y vinculación con sus vehículos identificados por patente, marca normalizada, modelo, año y kilometraje.

Órdenes de Trabajo: Seguimiento del estado de reparaciones (Pendiente, En Proceso, Esperando Repuestos, Finalizada, Entregada), capturando diagnósticos iniciales, fechas prometidas/de entrega y kilometraje histórico al ingreso.

Asignación de Personal: Administración de mecánicos activos y asignación según especialidad técnica.

Control de Inventario y Proveedores: Gestión de catálogo de repuestos, precios unitarios, alertas de stock mínimo y contacto con proveedores.

Trazabilidad e Historiales: Auditoría automática de cambios de estado en las órdenes y registro histórico de variaciones de precios en repuestos.

La base de datos gestiona las siguientes entidades:

CLIENTES

VEHICULOS y MARCAS

MECANICOS

ESTADOS_ORDEN e HISTORIAL_ESTADOS

ORDENES_TRABAJO

PROVEEDORES, REPUESTOS e HISTORIAL_PRECIOS_REPUESTOS

DETALLE_ORDEN_REPUESTOS



Grupo 30 - UTN FRGP