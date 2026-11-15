using System;
using System.Web.UI;
using TallerMecanico.Datos;

namespace TallerMecanicoWeb
{
    public partial class Inventario : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarInventario();
        }

        private void CargarInventario()
        {
            AccesoDatos datos = new AccesoDatos();

            datos.SetearConsulta("SELECT Codigo AS [Código], Repuesto, StockActual AS [Stock Actual], StockMinimo AS [Mínimo], Proveedor, ContactoProveedor AS [Teléfono Proveedor] FROM VW_RepuestosStockCritico");
            gvStockCritico.DataSource = datos.EjecutarConsultaTabla();
            gvStockCritico.DataBind();

            datos.SetearConsulta("SELECT Codigo AS [Código], Nombre AS [Repuesto], Descripcion AS [Descripción], PrecioUnitario AS [Precio ($)], StockActual AS [Stock] FROM REPUESTOS");
            gvCatalogo.DataSource = datos.EjecutarConsultaTabla();
            gvCatalogo.DataBind();

            datos.SetearConsulta("SELECT IDRepuesto, Codigo + ' - ' + Nombre + ' ($' + CAST(PrecioUnitario AS VARCHAR) + ')' AS Info FROM REPUESTOS");
            ddlRepuestosPrecio.DataSource = datos.EjecutarConsultaTabla();
            ddlRepuestosPrecio.DataTextField = "Info";
            ddlRepuestosPrecio.DataValueField = "IDRepuesto";
            ddlRepuestosPrecio.DataBind();
        }

        protected void btnActualizarPrecio_Click(object sender, EventArgs e)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                decimal nuevoPrecio = decimal.Parse(txtNuevoPrecio.Text);
                datos.SetearConsulta("UPDATE REPUESTOS SET PrecioUnitario = @Precio WHERE IDRepuesto = @IDRepuesto");
                datos.SetearParametro("@Precio", nuevoPrecio);
                datos.SetearParametro("@IDRepuesto", int.Parse(ddlRepuestosPrecio.SelectedValue));
                datos.EjecutarAccion();

                pnlAlerta.Visible = true;
                pnlAlerta.CssClass = "alert alert-success shadow-sm mb-4";
                lblAlerta.Text = "Precio actualizado y registrado en el historial de auditoría.";
                txtNuevoPrecio.Text = "";
                CargarInventario();
            }
            catch (Exception ex)
            {
                pnlAlerta.Visible = true;
                pnlAlerta.CssClass = "alert alert-danger shadow-sm mb-4";
                lblAlerta.Text = "Error: " + ex.Message;
            }
        }
    }
}