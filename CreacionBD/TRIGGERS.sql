USE TallerMecanicoDB;
GO

--Descuenta stock y recalcula CostoTotal
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

--Delete para clientes
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