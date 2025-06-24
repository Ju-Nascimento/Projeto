<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lancamentos.aspx.cs" Inherits="Projeto.Pages.Editar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-6">

                <div class="m-2" id="FormVendas">
                    
                    <asp:Label CssClass="form-label" ID="labelCategoria" runat="server" Text="Categoria: "></asp:Label> 
                    <asp:DropDownList CssClass="form-select" ID="dropCategorias" runat="server"></asp:DropDownList>

                    <asp:Label CssClass="form-label" ID="labelMarcas" runat="server" Text="Marca:"></asp:Label> 
                    <asp:DropDownList CssClass="form-select" ID="dropMarcas" runat="server"></asp:DropDownList>

                    <asp:Label CssClass="form-label" ID="labelProdutos" runat="server" Text="Produto:"></asp:Label> 
                    <asp:DropDownList CssClass="form-select" ID="dropProdutos" runat="server"></asp:DropDownList>

                    <asp:Label CssClass="form-label" ID="labelQTD" runat="server" Text="Quantidade:"></asp:Label> 
                    <asp:TextBox CssClass="form-control" ID="txtQtd" runat="server"></asp:TextBox>

                    <asp:Label CssClass="form-label" ID="labelTotal" runat="server" Text="Subtotal"></asp:Label> 
                    <asp:TextBox CssClass="form-control" ID="txtTotal" runat="server"></asp:TextBox>

                    <asp:Label CssClass="form-label" ID="labelData" runat="server" Text="Data: "></asp:Label> 
                    <asp:TextBox CssClass="form-control" ID="txtData" runat="server"></asp:TextBox>

                    <asp:Button ID="Button1" runat="server" Text="Confirmar" />
                    <asp:Button ID="Button2" runat="server" Text="Cancelar" />
                </div>

                <div class="m-2"id="viewVendas">

                </div>
            </div>
        </div>
    </main>
</asp:Content>
