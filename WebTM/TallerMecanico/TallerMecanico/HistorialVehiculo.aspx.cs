using System;
using System.Web.UI;
using TallerMecanico.Datos;

namespace TallerMecanicoWeb
{
    public partial class HistorialVehiculo : Page
    {
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            lblError.Visible = false;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearProcedimiento("SP_ReporteHistorialVehiculo");
                datos.SetearParametro("@Patente", txtPatente.Text.Trim().ToUpper());
                gvHistorial.DataSource = datos.EjecutarConsultaTabla();
                gvHistorial.DataBind();
            }
            catch (Exception ex)
            {
                gvHistorial.DataSource = null;
                gvHistorial.DataBind();
                lblError.Text = ex.Message;
                lblError.Visible = true;
            }
        }
    }
}