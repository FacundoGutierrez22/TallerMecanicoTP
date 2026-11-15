using System;
using System.Web.UI;
using TallerMecanico.Datos;

namespace TallerMecanicoWeb
{
    public partial class Ordenes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarPantalla();
        }

        private void CargarPantalla()
        {
            AccesoDatos datos = new AccesoDatos();

            datos.SetearConsulta(@"
                SELECT ot.IDOrden, 
                       'Orden #' + CAST(ot.IDOrden AS VARCHAR) + ' - ' + v.Patente + ' (' + m.NombreMarca + ' ' + v.Modelo + ')' AS Info
                FROM ORDENES_TRABAJO ot
                INNER JOIN VEHICULOS v ON ot.Patente = v.Patente
                INNER JOIN MARCAS m ON v.IDMarca = m.IDMarca");
            var dtOrdenes = datos.EjecutarConsultaTabla();

            ddlOrdenes.DataSource = dtOrdenes;
            ddlOrdenes.DataTextField = "Info";
            ddlOrdenes.DataValueField = "IDOrden";
            ddlOrdenes.DataBind();

            ddlOrdenEstado.DataSource = dtOrdenes;
            ddlOrdenEstado.DataTextField = "Info";
            ddlOrdenEstado.DataValueField = "IDOrden";
            ddlOrdenEstado.DataBind();

            datos.SetearConsulta("SELECT IDRepuesto, Nombre + ' ($' + CAST(PrecioUnitario AS VARCHAR) + ') - Stock: ' + CAST(StockActual AS VARCHAR) AS Info FROM REPUESTOS");
            ddlRepuestos.DataSource = datos.EjecutarConsultaTabla();
            ddlRepuestos.DataTextField = "Info";
            ddlRepuestos.DataValueField = "IDRepuesto";
            ddlRepuestos.DataBind();

            datos.SetearConsulta("SELECT IDEstado, NombreEstado FROM ESTADOS_ORDEN");
            ddlEstados.DataSource = datos.EjecutarConsultaTabla();
            ddlEstados.DataTextField = "NombreEstado";
            ddlEstados.DataValueField = "IDEstado";
            ddlEstados.DataBind();

            datos.SetearConsulta(@"
                SELECT ot.IDOrden AS [N° Orden], ot.Patente, eo.NombreEstado AS [Estado], 
                       mec.Nombre + ' ' + mec.Apellido AS [Mecánico], 
                       ot.CostoManoObra AS [Mano de Obra ($)], ot.CostoTotal AS [Total Final ($)]
                FROM ORDENES_TRABAJO ot
                INNER JOIN ESTADOS_ORDEN eo ON ot.IDEstado = eo.IDEstado
                INNER JOIN MECANICOS mec ON ot.IDMecanico = mec.IDMecanico");
            gvOrdenes.DataSource = datos.EjecutarConsultaTabla();
            gvOrdenes.DataBind();
        }

        protected void btnAgregarRepuesto_Click(object sender, EventArgs e)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearProcedimiento("SP_AgregarRepuestoAOrden");
                datos.SetearParametro("@IDOrden", int.Parse(ddlOrdenes.SelectedValue));
                datos.SetearParametro("@IDRepuesto", int.Parse(ddlRepuestos.SelectedValue));
                datos.SetearParametro("@Cantidad", int.Parse(txtCantidad.Text));
                datos.EjecutarAccion();

                MostrarAlerta("Repuesto registrado con éxito. Se actualizó el stock y el total de la orden.", true);
                CargarPantalla();
            }
            catch (Exception ex)
            {
                MostrarAlerta(ex.Message, false);
            }
        }

        protected void btnCambiarEstado_Click(object sender, EventArgs e)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearConsulta("UPDATE ORDENES_TRABAJO SET IDEstado = @IDEstado WHERE IDOrden = @IDOrden");
                datos.SetearParametro("@IDEstado", int.Parse(ddlEstados.SelectedValue));
                datos.SetearParametro("@IDOrden", int.Parse(ddlOrdenEstado.SelectedValue));
                datos.EjecutarAccion();

                MostrarAlerta("Estado actualizado correctamente y registrado en el historial de seguimiento.", true);
                CargarPantalla();
            }
            catch (Exception ex)
            {
                MostrarAlerta(ex.Message, false);
            }
        }

        private void MostrarAlerta(string msg, bool ok)
        {
            pnlAlerta.Visible = true;
            pnlAlerta.CssClass = ok ? "alert alert-success shadow-sm mb-4" : "alert alert-danger shadow-sm mb-4";
            lblAlerta.Text = msg;
        }
    }
}