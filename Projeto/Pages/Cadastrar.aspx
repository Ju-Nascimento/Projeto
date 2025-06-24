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
                    <asp:DropDownList ID="ddlMarca" runat="server" DataSourceID="Marcas" DataTextField="Nome" DataValueField="Id" CssClass="form-select"></asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="Marcas"
                        ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                        SelectCommand="SELECT Id, Nome FROM Marca"></asp:SqlDataSource>
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
                    <asp:DropDownList CssClass="form-select" ID="ddlCategoria" runat="server" DataSourceID="Categorias" DataTextField="Nome" DataValueField="Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="Categorias"
                        ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                        SelectCommand="SELECT Id, Nome FROM Categorias"></asp:SqlDataSource>

                </div>
                <asp:Button class="btn btn-primary btn-md" ID="bttSalvar" runat="server" Text="Salvar" OnClick="bttSalvar_Click" />
                <asp:Button class="btn btn-primary btn-md" ID="Button2" runat="server" Text="Cancelar" />
                <asp:Label CssClass="form-label" ID="lblMensagem" runat="server"></asp:Label>
            </div>
            <div>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="Produtos"></asp:GridView>
                <asp:SqlDataSource runat="server" ID="Produtos" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT * FROM [Produtos]"></asp:SqlDataSource>
            </div>
        </div>
    </main>
</asp:Content>
