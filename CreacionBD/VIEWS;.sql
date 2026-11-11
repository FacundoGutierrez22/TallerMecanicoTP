USE TallerMecanicoDB;
GO

--vista VW_VehiculosEnReparacion: tehículos actualmente en estado "En Proceso"
CREATE VIEW VW_VehiculosEnReparacion AS
SELECT 
    ot.IDOrden,
    v.Patente,
    m.NombreMarca AS Marca,
    v.Modelo,
    c.Nombre + ' ' + c.Apellido AS Cliente,
    c.Telefono AS TelefonoCliente,
    mec.Nombre + ' ' + mec.Apellido AS MecanicoAsignado,
    ot.FechaIngreso,
    ot.DiagnosticoInicial
FROM ORDENES_TRABAJO ot
INNER JOIN VEHICULOS v ON ot.Patente = v.Patente
INNER JOIN MARCAS m ON v.IDMarca = m.IDMarca
INNER JOIN CLIENTES c ON v.IDCliente = c.IDCliente
INNER JOIN MECANICOS mec ON ot.IDMecanico = mec.IDMecanico
INNER JOIN ESTADOS_ORDEN eo ON ot.IDEstado = eo.IDEstado
WHERE eo.NombreEstado = 'En Proceso';
GO

--vista VW_IngresosPorMecanico: total acumulado por mano de obra agrupado por mecánico
CREATE VIEW VW_IngresosPorMecanico AS
SELECT 
    m.IDMecanico,
    m.Nombre + ' ' + m.Apellido AS Mecanico,
    m.Especialidad,
    COUNT(ot.IDOrden) AS CantidadOrdenesAtendidas,
    ISNULL(SUM(ot.CostoManoObra), 0) AS TotalManoObraAcumulado
FROM MECANICOS m
LEFT JOIN ORDENES_TRABAJO ot ON m.IDMecanico = ot.IDMecanico
GROUP BY m.IDMecanico, m.Nombre, m.Apellido, m.Especialidad;
GO