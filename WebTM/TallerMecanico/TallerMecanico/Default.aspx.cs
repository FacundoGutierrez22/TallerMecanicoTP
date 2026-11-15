using System;
using System.Web.UI;
using TallerMecanico.Datos;

namespace TallerMecanico
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AccesoDatos datos = new AccesoDatos();
                datos.SetearConsulta("SELECT IDOrden AS [N° Orden], Patente, Marca, Modelo, Cliente, TelefonoCliente AS [Teléfono], MecanicoAsignado AS [Mecánico], FechaIngreso AS [Ingreso], DiagnosticoInicial AS [Diagnóstico] FROM VW_VehiculosEnReparacion");
                gvEnReparacion.DataSource = datos.EjecutarConsultaTabla();
                gvEnReparacion.DataBind();

                datos.SetearConsulta("SELECT Mecanico AS [Mecánico], Especialidad, CantidadOrdenesAtendidas AS [Órdenes Atendidas], TotalManoObraAcumulado AS [Total Mano de Obra ($)] FROM VW_IngresosPorMecanico");
                gvMecanicos.DataSource = datos.EjecutarConsultaTabla();
                gvMecanicos.DataBind();
            }
        }
    }
}