USE TallerMecanicoDB;
GO

-- SP 1: Consulta del historial de reparaciones por patente
CREATE PROCEDURE SP_ReporteHistorialVehiculo
    @Patente VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF NOT EXISTS (SELECT 1 FROM VEHICULOS WHERE Patente = @Patente)
    BEGIN
        RAISERROR('La patente ingresada no existe en el sistema.', 16, 1);
        RETURN;
    END

    SELECT 
        ot.IDOrden,
        ot.FechaIngreso,
        ot.FechaEntrega,
        ot.Kilometraje,
        eo.NombreEstado,
        ot.DiagnosticoInicial,
        ot.CostoManoObra,
        ot.CostoTotal
    FROM ORDENES_TRABAJO ot
    INNER JOIN ESTADOS_ORDEN eo ON ot.IDEstado = eo.IDEstado
    WHERE ot.Patente = @Patente
    ORDER BY ot.FechaIngreso DESC;
END;
GO

USE TallerMecanicoDB;
GO

-- SP 2: Agregar repuesto a una orden con manejo de transacciones, TRY-CATCH y validaciones
CREATE OR ALTER PROCEDURE SP_AgregarRepuestoAOrden
    @IDOrden INT,
    @IDRepuesto INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Validar que la cantidad solicitada sea válida
        IF @Cantidad <= 0
            THROW 50001, 'La cantidad de repuestos debe ser mayor a cero.', 1;

        -- 2. Validar que la Orden de Trabajo exista
        IF NOT EXISTS (SELECT 1 FROM ORDENES_TRABAJO WHERE IDOrden = @IDOrden)
            THROW 50002, 'La orden de trabajo especificada no existe.', 1;

        -- 3. Obtener precio actual y stock disponible del repuesto
        DECLARE @PrecioUnitario DECIMAL(10,2);
        DECLARE @StockActual INT;
        
        SELECT 
            @PrecioUnitario = PrecioUnitario,
            @StockActual = StockActual
        FROM REPUESTOS 
        WHERE IDRepuesto = @IDRepuesto;

        -- 4. Validar existencia del repuesto y disponibilidad de stock
        IF @PrecioUnitario IS NULL
            THROW 50003, 'El repuesto especificado no existe.', 1;

        IF @StockActual < @Cantidad
            THROW 50004, 'Stock insuficiente para realizar la operación.', 1;

        -- 5. Calcular subtotal e insertar en el detalle (dispara el trigger de stock y total)
        DECLARE @Subtotal DECIMAL(10,2) = @PrecioUnitario * @Cantidad;
        
        INSERT INTO DETALLE_ORDEN_REPUESTOS (IDOrden, IDRepuesto, Cantidad, PrecioUnitario, Subtotal)
        VALUES (@IDOrden, @IDRepuesto, @Cantidad, @PrecioUnitario, @Subtotal);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si hay una transacción activa al ocurrir cualquier error, se revierte por completo
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Relanza el error original hacia el cliente (SSMS o aplicación C#)
        THROW;
    END CATCH
END;
GO