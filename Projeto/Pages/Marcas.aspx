<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="Projeto.Pages.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6">
                <div class="d-flex align-items-center mb-2">
                    <asp:Label CssClass="form-label me-2 mb-0" ID="lblMarca" runat="server" Text="Nova Marca:"></asp:Label>
                    <asp:TextBox CssClass="form-control" Style="width: 60%;" ID="txtMarca" runat="server"></asp:TextBox>
                </div>

                <div class="mb-2">
                    <asp:Button CssClass="btn btn-primary me-2" ID="bttSalvar" runat="server" Text="Cadastrar" OnClick="bttSalvar_Click" />
                    <asp:Button CssClass="btn btn-secondary" ID="bttCancelar" runat="server" Text="Cancelar" OnClick="bttCancelar_Click" />
                </div>

                <div>
                    <asp:Label CssClass="form-text text-success" ID="lblMensagem" runat="server" Text=""></asp:Label> 
                </div>
            </div>
          
            <div class="col-md-6">
                <asp:GridView ID="GridMarcas" runat="server"
                    CssClass="table table-bordered table-striped text-center"
                    AutoGenerateColumns="False" DataSourceID="Grid_Marcas">
                    <Columns>
                        <asp:BoundField DataField="Nome" HeaderText="Marcas Cadastradas" SortExpression="Nome" />
                    </Columns>
                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="Grid_Marcas"
                    ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                    SelectCommand="SELECT [Nome] FROM [Marca]">
                </asp:SqlDataSource>
            </div>

        </div>
    </div>
</asp:Content>

