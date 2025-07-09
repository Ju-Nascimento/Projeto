<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lancamentos.aspx.cs" Inherits="Projeto.Pages.Editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">

        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div class="card p-3 w-100">
                    <div class="row">
                        <div class="col-md-2 mb-2">
                            <asp:Label CssClass="form-label" ID="lblTipo" runat="server" Text="Tipo:" />
                            <asp:DropDownList ID="DropTipo" runat="server" CssClass="form-select">
                                <asp:ListItem Value="">Selecione</asp:ListItem>
                                <asp:ListItem>Entrada</asp:ListItem>
                                <asp:ListItem>Saida</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-2 mb-2">
                            <asp:Label CssClass="form-label" ID="lblCategoria" runat="server" Text="Categoria:" />
                            <asp:DropDownList ID="DropCategorias" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropCategorias_SelectedIndexChanged" CssClass="form-select" />
                        </div>
                        <div class="col-md-2 mb-2">
                            <asp:Label CssClass="form-label" ID="lblMarca" runat="server" Text="Marca:" />
                            <asp:DropDownList ID="DropMarcas" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropMarcas_SelectedIndexChanged" CssClass="form-select" />
                        </div>
                        <div class="col-md-2 mb-2">
                            <asp:Label CssClass="form-label" ID="lblProduto" runat="server" Text="Produto:" />
                            <asp:DropDownList ID="DropProdutos" runat="server" CssClass="form-select" />
                        </div>
                        <div class="col-md-2 mb-2">
                            <asp:Label CssClass="form-label" ID="lblQtd" runat="server" Text="Quantidade:" />
                            <asp:TextBox ID="txtQtd" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-2 d-flex align-items-end mb-2">
                            <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar" OnClick="btnConfirmar_Click" CssClass="btn btn-primary me-2" />
                            <asp:Button ID="Button2" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="Button2_Click" />
                        </div>
                        <div class="col-md-12">
                            <asp:Label ID="lblMensagem" runat="server" CssClass="form-label text-success" Visible="false" />
                            <asp:HiddenField ID="hfId" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-12">
                <asp:GridView ID="GridLancamentos" runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-bordered table-striped text-center"
                    DataKeyNames="Id"
                    DataSourceID="LancamentosDataSource"
                    OnRowCommand="GridLancamentos_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                        <asp:BoundField DataField="Produto" HeaderText="Produto" />
                        <asp:BoundField DataField="Categoria" HeaderText="Categoria" />
                        <asp:BoundField DataField="Marca" HeaderText="Marca" />
                        <asp:BoundField DataField="QTD" HeaderText="Quantidade" />
                        <asp:TemplateField HeaderText="Ações">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' Text="✏️" ToolTip="Editar" />
                                <asp:LinkButton ID="btnExcluir" runat="server" CommandName="Excluir" CommandArgument='<%# Eval("Id") %>' Text="🗑️" ToolTip="Excluir" OnClientClick="return confirm('Deseja realmente excluir?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="LancamentosDataSource" runat="server"
                    ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
                    SelectCommand="SELECT L.Id, L.Tipo, P.Nome AS Produto, C.Nome AS Categoria, M.Nome AS Marca, L.QTD
                                   FROM Lancamentos L
                                   INNER JOIN Produtos P ON L.ProdutoID = P.Id
                                   INNER JOIN Categorias C ON L.CategoriaID = C.Id
                                   INNER JOIN Marca M ON L.MarcaID = M.Id
                                   WHERE L.Ativo = 1"></asp:SqlDataSource>
            </div>
        </div>
    </main>
</asp:Content>
