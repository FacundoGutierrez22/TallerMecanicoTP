<%@ Page Title="Inventario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inventario.aspx.cs" Inherits="TallerMecanicoWeb.Inventario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlAlerta" runat="server" Visible="false" CssClass="alert shadow-sm mb-4">
        <asp:Label ID="lblAlerta" runat="server"></asp:Label>
    </asp:Panel>

    <!-- Vista 3: VW_RepuestosStockCritico -->
    <div class="card border-0 shadow-sm mb-4 border-start border-danger border-4">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold text-danger">Alerta de Reposición: Repuestos con Stock Crítico</h5>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvStockCritico" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None" EmptyDataText="No hay repuestos por debajo del stock mínimo.">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
            </asp:GridView>
        </div>
    </div>

    <div class="row g-4">
        <!-- Catálogo General -->
        <div class="col-md-8">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Catálogo Completo de Repuestos</h5>
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvCatalogo" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None">
                        <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Actualizar Precio (Dispara Trigger TR_Repuestos_HistorialPrecios) -->
        <div class="col-md-4">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Actualizar Precio Lista</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Repuesto</label>
                        <asp:DropDownList ID="ddlRepuestosPrecio" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nuevo Precio Unitario ($)</label>
                        <asp:TextBox ID="txtNuevoPrecio" runat="server" CssClass="form-control" placeholder="Ej: 18500"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnActualizarPrecio" runat="server" Text="Guardar Nuevo Precio" CssClass="btn btn-dark w-100" OnClick="btnActualizarPrecio_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>