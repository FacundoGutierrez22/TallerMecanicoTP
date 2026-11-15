<%@ Page Title="Órdenes de Trabajo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ordenes.aspx.cs" Inherits="TallerMecanicoWeb.Ordenes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlAlerta" runat="server" Visible="false" CssClass="alert shadow-sm mb-4">
        <asp:Label ID="lblAlerta" runat="server"></asp:Label>
    </asp:Panel>

    <div class="row g-4 mb-4">
        <!-- Cargar Repuesto (SP_AgregarRepuestoAOrden + Trigger INSERT) -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Cargar Repuesto a Orden</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Seleccionar Orden</label>
                        <asp:DropDownList ID="ddlOrdenes" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-8">
                            <label class="form-label fw-semibold">Repuesto</label>
                            <asp:DropDownList ID="ddlRepuestos" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-4">
                            <label class="form-label fw-semibold">Cantidad</label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" Text="1" min="1"></asp:TextBox>
                        </div>
                    </div>
                    <asp:Button ID="btnAgregarRepuesto" runat="server" Text="Agregar Insumo a la Orden" CssClass="btn btn-success w-100" OnClick="btnAgregarRepuesto_Click" />
                </div>
            </div>
        </div>

        <!-- Cambiar Estado de Orden (Dispara Trigger UPDATE de Historial de Estados) -->
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">Actualizar Estado de Reparación</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Orden de Trabajo</label>
                        <asp:DropDownList ID="ddlOrdenEstado" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Nuevo Estado</label>
                        <asp:DropDownList ID="ddlEstados" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <asp:Button ID="btnCambiarEstado" runat="server" Text="Guardar Nuevo Estado" CssClass="btn btn-primary w-100" OnClick="btnCambiarEstado_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Listado de Órdenes y Totales Actualizados -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold">Listado General de Órdenes de Trabajo</h5>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvOrdenes" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>