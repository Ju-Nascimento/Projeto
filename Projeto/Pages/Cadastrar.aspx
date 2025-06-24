<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cadastrar.aspx.cs" Inherits="Projeto.Pages.Cadastrar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-6">
                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="labelNome" runat="server" Text="Nome: "></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtNome" runat="server"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="labelMarca" runat="server" Text="Marca: "></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtMarca" runat="server"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="labelPreco" runat="server" Text="Preço: "></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtPreco" runat="server"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="labelQtd" runat="server" Text="Quantidade"></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtQtd" runat="server"></asp:TextBox>
                </div>
                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="labelCategoria" runat="server" Text="Categoria"></asp:Label>
                    <asp:DropDownList CssClass="form-select" ID="DropDownList1" runat="server">
                        <asp:ListItem Text="Selecione" Value="" />
                        <asp:ListItem>Pneus</asp:ListItem>
                        <asp:ListItem>Peças</asp:ListItem>
                        <asp:ListItem>Acessorios</asp:ListItem>
                        <asp:ListItem>Óleos</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Button class="btn btn-primary btn-md" ID="Button1" runat="server" Text="Salvar" />
                <asp:Button class="btn btn-primary btn-md" ID="Button2" runat="server" Text="Cancelar" />

            </div>
        </div>
    </main>
</asp:Content>
