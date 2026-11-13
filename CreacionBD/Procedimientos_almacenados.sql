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

-- SP 2: Agregar repuesto a una orden con manejo de transacciones, TRY-CATCH y cálculo de costos
CREATE PROCEDURE SP_AgregarRepuestoAOrden
    @IDOrden INT,
    @IDRepuesto INT,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @PrecioUnitario DECIMAL(10,2);
        DECLARE @StockActual INT;
        
        -- Obtener precio actual y stock disponible
        SELECT 
            @PrecioUnitario = PrecioUnitario,
            @StockActual = StockActual
        FROM REPUESTOS 
        WHERE IDRepuesto = @IDRepuesto;

        -- Validar existencia y stock suficiente
        IF @PrecioUnitario IS NULL
        BEGIN
            RAISERROR('El repuesto especificado no existe.', 16, 1);
            RETURN;
        END

        IF @StockActual < @Cantidad
        BEGIN
            RAISERROR('Stock insuficiente para realizar la operación.', 16, 1);
            RETURN;
        END

        DECLARE @Subtotal DECIMAL(10,2) = @PrecioUnitario * @Cantidad;
        
        -- Registrar detalle
        INSERT INTO DETALLE_ORDEN_REPUESTOS (IDOrden, IDRepuesto, Cantidad, PrecioUnitario, Subtotal)
        VALUES (@IDOrden, @IDRepuesto, @Cantidad, @PrecioUnitario, @Subtotal);

       
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO