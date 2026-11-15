<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="TallerMecanico.Clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlAlerta" runat="server" Visible="false" CssClass="alert alert-success shadow-sm mb-4">
        <asp:Label ID="lblAlerta" runat="server"></asp:Label>
    </asp:Panel>

    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 fw-bold">Padrón de Clientes Registrados</h5>
        </div>
        <div class="card-body">
            <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" DataKeyNames="IDCliente"
                CssClass="table table-hover align-middle mb-0" GridLines="None" OnRowDeleting="gvClientes_RowDeleting">
                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
                <Columns>
                    <asp:BoundField DataField="DNI" HeaderText="DNI" />
                    <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre y Apellido" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("Activo")) ? "badge bg-success" : "badge bg-secondary" %>'>
                                <%# Convert.ToBoolean(Eval("Activo")) ? "Activo" : "Dado de baja" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:Button ID="btnEliminar" runat="server" CommandName="Delete" Text="Dar de baja"
                                CssClass="btn btn-sm btn-outline-danger"
                                Visible='<%# Convert.ToBoolean(Eval("Activo")) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>