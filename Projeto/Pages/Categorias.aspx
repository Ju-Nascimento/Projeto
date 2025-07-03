<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="Projeto.Pages.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row">
           
            <div class="col-md-6">
                
                <div class="d-flex align-items-center mb-2">
                    <asp:Label CssClass="form-label me-2 mb-0" ID="lblCategoria" runat="server" Text="Nova Categoria:"></asp:Label>
                    <asp:TextBox CssClass="form-control" Style="width: 60%;" ID="txtCategoria" runat="server"></asp:TextBox>
                </div>

                <div class="mb-2">
                    <asp:Button CssClass="btn btn-primary me-2" ID="bttSalvar" runat="server" Text="Cadastrar" OnClick="bttSalvar_Click" />
                    <asp:Button CssClass="btn btn-secondary" ID="bttCancelar" runat="server" Text="Cancelar" OnClick="bttCancelar_Click" />
                </div>

                <div>
                    <asp:Label CssClass="form-text text-success" ID="msg" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="col-md-6">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="Grid_Categorias" 
                    AutoGenerateColumns="False" CssClass="table table-bordered table-striped text-center">
                    <Columns>
                        <asp:BoundField DataField="Nome" HeaderText="Categorias de Produtos" />
                    </Columns>
                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="Grid_Categorias"
                    ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                    SelectCommand="SELECT [Nome] FROM [Categorias]">
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
