USE TallerMecanicoDB;
GO

-- =============================================
-- PROYECTO INTEGRADOR - BASE DE DATOS II (UTN FRGP)
-- Archivo: TRIGGERS.sql
-- Integrantes: Facundo Gutiérrez, Alberto Alejandro Ponce (Grupo 30)
-- =============================================

-- 1. Trigger AFTER INSERT: Descuenta stock y recalcula CostoTotal de la orden
CREATE TRIGGER TR_DetalleOrden_AfterInsert
ON DETALLE_ORDEN_REPUESTOS
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;

UPDATE r
SET r.StockActual = r.StockActual - i.Cantidad
FROM REPUESTOS r
INNER JOIN INSERTED i ON r.IDRepuesto = i.IDRepuesto;

UPDATE ot
SET ot.CostoTotal = ot.CostoManoObra + ISNULL((
    SELECT SUM(d.Subtotal) 
    FROM DETALLE_ORDEN_REPUESTOS d 
    WHERE d.IDOrden = ot.IDOrden
), 0)
FROM ORDENES_TRABAJO ot
INNER JOIN INSERTED i ON ot.IDOrden = i.IDOrden;


END;
GO

-- 2. Trigger INSTEAD OF DELETE: Baja lógica de clientes (Activo = 0)
CREATE TRIGGER TR_Clientes_SoftDelete
ON CLIENTES
INSTEAD OF DELETE
AS
BEGIN
SET NOCOUNT ON;

UPDATE CLIENTES
SET Activo = 0
WHERE IDCliente IN (SELECT IDCliente FROM DELETED);


END;
GO

-- 3. Trigger AFTER UPDATE: Registra cada cambio de estado de una orden en HISTORIAL_ESTADOS
CREATE TRIGGER TR_Ordenes_HistorialEstados
ON ORDENES_TRABAJO
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;

IF UPDATE(IDEstado)
BEGIN
    INSERT INTO HISTORIAL_ESTADOS (IDOrden, IDEstado, FechaCambio)
    SELECT 
        i.IDOrden,
        i.IDEstado,
        GETDATE()
    FROM INSERTED i
    INNER JOIN DELETED d ON i.IDOrden = d.IDOrden
    WHERE i.IDEstado <> d.IDEstado;
END


END;
GO

-- 4. Trigger AFTER UPDATE: Audita las modificaciones de precio unitario en HISTORIAL_PRECIOS_REPUESTOS
CREATE TRIGGER TR_Repuestos_HistorialPrecios
ON REPUESTOS
AFTER UPDATE
AS
BEGIN
SET NOCOUNT ON;

IF UPDATE(PrecioUnitario)
BEGIN
    INSERT INTO HISTORIAL_PRECIOS_REPUESTOS (IDRepuesto, PrecioAnterior, PrecioNuevo, FechaModificacion)
    SELECT 
        d.IDRepuesto,
        d.PrecioUnitario,
        i.PrecioUnitario,
        GETDATE()
    FROM DELETED d
    INNER JOIN INSERTED i ON d.IDRepuesto = i.IDRepuesto
    WHERE d.PrecioUnitario <> i.PrecioUnitario;
END


END;
GO