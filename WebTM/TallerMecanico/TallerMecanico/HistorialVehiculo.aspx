<%@ Page Title="Historial por Patente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistorialVehiculo.aspx.cs" Inherits="TallerMecanicoWeb.HistorialVehiculo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold">Consulta de Historial Técnico por Patente</h5>
        </div>
        <div class="card-body">
            <div class="row g-2 mb-3" style="max-width: 480px;">
                <div class="col">
                    <asp:TextBox ID="txtPatente" runat="server" CssClass="form-control text-uppercase" placeholder="Ingrese patente (Ej: AA123BC)" MaxLength="15"></asp:TextBox>
                </div>
                <div class="col-auto">
                    <asp:Button ID="btnBuscar" runat="server" Text="Consultar Ficha" CssClass="btn btn-primary px-4" OnClick="btnBuscar_Click" />
                </div>
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="text-danger fw-semibold d-block mb-3" Visible="false"></asp:Label>

            <asp:GridView ID="gvHistorial" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None" EmptyDataText="Sin registros para mostrar.">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>