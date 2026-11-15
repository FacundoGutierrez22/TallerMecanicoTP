<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TallerMecanico.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="p-4 mb-4 bg-white rounded-3 shadow-sm border-start border-primary border-5">
        <h2 class="fw-bold mb-1">Bienvenido al Sistema de Gestión del Taller</h2>
        <p class="text-muted mb-0">Visualización en tiempo real de vehículos en reparación y productividad del equipo técnico.</p>
    </div>

    <!-- Vista 1: VW_VehiculosEnReparacion -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold">Vehículos Actualmente en Reparación</h5>
            <a href="Ordenes.aspx" class="btn btn-sm btn-primary">Gestionar Órdenes</a>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvEnReparacion" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None" EmptyDataText="No hay vehículos en proceso actualmente.">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
            </asp:GridView>
        </div>
    </div>

    <!-- Vista 2: VW_IngresosPorMecanico -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold">Rendimiento y Facturación de Mano de Obra por Mecánico</h5>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvMecanicos" runat="server" CssClass="table table-hover align-middle mb-0" GridLines="None">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>