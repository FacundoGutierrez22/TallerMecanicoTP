CREATE DATABASE TallerMecanicoDB;
GO

USE TallerMecanicoDB;
GO

CREATE TABLE CLIENTES (
    IDCliente INT IDENTITY(1,1) PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(150),
    Activo BIT DEFAULT 1
);
GO

CREATE TABLE MARCAS (
    IDMarca INT IDENTITY(1,1) PRIMARY KEY,
    NombreMarca VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE VEHICULOS (
    Patente VARCHAR(15) PRIMARY KEY,
    IDCliente INT NOT NULL,
    IDMarca INT NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Anio INT CHECK (Anio >= 1900),
    Kilometraje INT CHECK (Kilometraje >= 0),
    FOREIGN KEY (IDCliente) REFERENCES CLIENTES(IDCliente),
    FOREIGN KEY (IDMarca) REFERENCES MARCAS(IDMarca)
);
GO

CREATE TABLE MECANICOS (
    IDMecanico INT IDENTITY(1,1) PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Especialidad VARCHAR(100),
    Telefono VARCHAR(20),
    Activo BIT DEFAULT 1
);
GO

CREATE TABLE ESTADOS_ORDEN (
    IDEstado INT IDENTITY(1,1) PRIMARY KEY,
    NombreEstado VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE PROVEEDORES (
    IDProveedor INT IDENTITY(1,1) PRIMARY KEY,
    RazonSocial VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);
GO

CREATE TABLE REPUESTOS (
    IDRepuesto INT IDENTITY(1,1) PRIMARY KEY,
    IDProveedor INT NOT NULL,
    Codigo VARCHAR(50) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    PrecioUnitario DECIMAL(10,2) CHECK (PrecioUnitario >= 0),
    StockActual INT CHECK (StockActual >= 0),
    StockMinimo INT DEFAULT 5,
    FOREIGN KEY (IDProveedor) REFERENCES PROVEEDORES(IDProveedor)
);
GO
CREATE TABLE ORDENES_TRABAJO (
    IDOrden INT IDENTITY(1,1) PRIMARY KEY,
    Patente VARCHAR(15) NOT NULL,
    IDMecanico INT NOT NULL,
    IDEstado INT NOT NULL,
    Kilometraje INT NOT NULL CHECK (Kilometraje >= 0),
    FechaIngreso DATETIME NOT NULL DEFAULT GETDATE(),
    FechaPrometida DATE NULL,
    FechaEntrega DATETIME NULL,
    DiagnosticoInicial VARCHAR(MAX) NULL,
    CostoManoObra DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (CostoManoObra >= 0),
    CostoTotal DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (CostoTotal >= 0),
    FOREIGN KEY (Patente) REFERENCES VEHICULOS(Patente),
    FOREIGN KEY (IDMecanico) REFERENCES MECANICOS(IDMecanico),
    FOREIGN KEY (IDEstado) REFERENCES ESTADOS_ORDEN(IDEstado),
    CONSTRAINT CHK_FechasOrden CHECK (FechaEntrega IS NULL OR FechaEntrega >= FechaIngreso)
);
GO

CREATE TABLE DETALLE_ORDEN_REPUESTOS (
    IDDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IDOrden INT NOT NULL,
    IDRepuesto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario >= 0),
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal >= 0),
    FOREIGN KEY (IDOrden) REFERENCES ORDENES_TRABAJO(IDOrden),
    FOREIGN KEY (IDRepuesto) REFERENCES REPUESTOS(IDRepuesto)
);
GO

CREATE TABLE HISTORIAL_ESTADOS (
    IDHistorial INT IDENTITY(1,1) PRIMARY KEY,
    IDOrden INT NOT NULL,
    IDEstado INT NOT NULL,
    FechaCambio DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (IDOrden) REFERENCES ORDENES_TRABAJO(IDOrden),
    FOREIGN KEY (IDEstado) REFERENCES ESTADOS_ORDEN(IDEstado)
);
GO

CREATE TABLE HISTORIAL_PRECIOS_REPUESTOS (
    IDHistorialPrecio INT IDENTITY(1,1) PRIMARY KEY,
    IDRepuesto INT NOT NULL,
    PrecioAnterior DECIMAL(10,2) NOT NULL,
    PrecioNuevo DECIMAL(10,2) NOT NULL,
    FechaModificacion DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (IDRepuesto) REFERENCES REPUESTOS(IDRepuesto)
);
GO
INSERT INTO ESTADOS_ORDEN (NombreEstado) VALUES 
('Pendiente'), ('En Proceso'), ('Esperando Repuestos'), ('Finalizada'), ('Entregada');
GO

INSERT INTO MARCAS (NombreMarca) VALUES 
('Toyota'), ('Ford'), ('Volkswagen'), ('Chevrolet'), ('Peugeot');
GO

INSERT INTO PROVEEDORES (RazonSocial, Telefono, Email) VALUES 
('Distribuidora Pacheco S.A.', '1147401122', 'contacto@distpacheco.com'),
('Autopartes Norte SRL', '1145129988', 'ventas@autopartesnorte.com.ar');
GO

INSERT INTO CLIENTES (DNI, Nombre, Apellido, Telefono, Email, Direccion, Activo) VALUES 
('35123456', 'Juan', 'Pérez', '1155443322', 'juan.perez@email.com', 'Av. Cazón 123, Tigre', 1),
('38987654', 'María', 'Gómez', '1166778899', 'maria.gomez@email.com', 'H. Yrigoyen 456, Pacheco', 1);
GO

INSERT INTO MECANICOS (DNI, Nombre, Apellido, Especialidad, Telefono, Activo) VALUES 
('30111222', 'Esteban', 'Quito', 'Mecánica General', '1134567890', 1),
('32333444', 'Jorge', 'Ríos', 'Electricidad e Inyección', '1145678901', 1);
GO

INSERT INTO VEHICULOS (Patente, IDCliente, IDMarca, Modelo, Anio, Kilometraje) VALUES 
('AA123BC', 1, 1, 'Corolla', 2018, 85000),
('AB456CD', 2, 2, 'Focus', 2017, 110000);
GO

INSERT INTO REPUESTOS (IDProveedor, Codigo, Nombre, Descripcion, PrecioUnitario, StockActual, StockMinimo) VALUES 
(1, 'REP-001', 'Filtro de Aceite', 'Filtro de aceite blindado', 8500.00, 45, 10),
(1, 'REP-002', 'Filtro de Aire', 'Filtro de aire panel', 12000.00, 3, 5),
(2, 'REP-003', 'Pastillas de Freno', 'Juego delantero', 38000.00, 20, 5);
GO

INSERT INTO ORDENES_TRABAJO (Patente, IDMecanico, IDEstado, Kilometraje, FechaIngreso, CostoManoObra, CostoTotal) VALUES 
('AA123BC', 1, 2, 85000, GETDATE(), 25000.00, 25000.00),
('AB456CD', 2, 1, 110000, GETDATE(), 30000.00, 30000.00);
GO

INSERT INTO DETALLE_ORDEN_REPUESTOS (IDOrden, IDRepuesto, Cantidad, PrecioUnitario, Subtotal) VALUES
(1, 1, 1, 8500.00, 8500.00),
(1, 2, 1, 12000.00, 12000.00);
GO
