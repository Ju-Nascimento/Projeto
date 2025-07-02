<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Consultar.aspx.cs" Inherits="Projeto.Pages.Consultar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-12">
                <div id="consultas" class="container m-3">
                    <div class="row align-items-center gx-3">

                        <!-- Categoria -->
                        <div class="col-md-3 d-flex align-items-center">
                            <asp:Label CssClass="form-label me-2 mb-0" ID="Label1" runat="server" Text="Categoria:"></asp:Label>
                            <asp:DropDownList
                                CssClass="form-select"
                                ID="DropDownList1"
                                runat="server"
                                DataSourceID="Categorias"
                                DataTextField="Nome"
                                DataValueField="Id"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="Selecione..." Value="" />
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="Categorias" runat="server"
                                ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                                SelectCommand="SELECT Id, Nome FROM Categorias" />
                        </div>

                        <!-- Marca -->
                        <div class="col-md-3 d-flex align-items-center">
                            <asp:Label CssClass="form-label me-2 mb-0" ID="Label2" runat="server" Text="Marca:"></asp:Label>
                            <asp:DropDownList
                                CssClass="form-select"
                                ID="DropDownList2"
                                runat="server"
                                DataSourceID="Marcas"
                                DataTextField="Nome"
                                DataValueField="Id"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="Selecione..." Value="" />
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="Marcas" runat="server"
                                ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                                SelectCommand="SELECT Id, Nome FROM Marca" />
                        </div>

                        <!-- Produto -->
                        <div class="col-md-3 d-flex align-items-center">
                            <asp:Label CssClass="form-label me-2 mb-0" ID="Label3" runat="server" Text="Produto:"></asp:Label>
                            <asp:DropDownList
                                CssClass="form-select"
                                ID="DropDownList3"
                                runat="server"
                                DataSourceID="Produtos"
                                DataTextField="Nome"
                                DataValueField="Id"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="Selecione..." Value="" />
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="Produtos" runat="server"
                                ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                                SelectCommand="SELECT Id, Nome FROM Produtos" />
                        </div>

                        <!-- Botões -->
                        <div class="col-md-3 d-flex gap-2">
                            <asp:Button ID="bttSalvar" runat="server" Text="Consultar" CssClass="btn btn-primary" OnClick="bttSalvar_Click" />
                            <asp:Button ID="Button2" runat="server" Text="Cancelar" CssClass="btn btn-secondary" />
                        </div>
                    </div>

                    <!-- Grid de resultados -->
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-striped">
                                <Columns>
                                    <asp:BoundField DataField="Nome" HeaderText="Produto" />
                                    <asp:BoundField DataField="Categoria" HeaderText="Categoria" />
                                    <asp:BoundField DataField="Marca" HeaderText="Marca" />
                                    <asp:BoundField DataField="Preco" HeaderText="Preço" DataFormatString="{0:C}" />
                                    <asp:BoundField DataField="QTD" HeaderText="Estoque" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>
</asp:Content>
