using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using TallerMecanico;
using TallerMecanico.Datos;

namespace TallerMecanico
{
    public partial class Clientes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarClientes();
        }

        private void CargarClientes()
        {
            AccesoDatos datos = new AccesoDatos();
            datos.SetearConsulta("SELECT IDCliente, DNI, Nombre + ' ' + Apellido AS NombreCompleto, Telefono, Email, Direccion, Activo FROM CLIENTES");
            gvClientes.DataSource = datos.EjecutarConsultaTabla();
            gvClientes.DataBind();
        }

        protected void gvClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int idCliente = Convert.ToInt32(gvClientes.DataKeys[e.RowIndex].Value);
            AccesoDatos datos = new AccesoDatos();
            datos.SetearConsulta("DELETE FROM CLIENTES WHERE IDCliente = @ID");
            datos.SetearParametro("@ID", idCliente);
            datos.EjecutarAccion();

            pnlAlerta.Visible = true;
            lblAlerta.Text = "El cliente fue dado de baja correctamente conservando su historial operativo.";
            CargarClientes();
        }
    }
}