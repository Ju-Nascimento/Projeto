<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cadastrar.aspx.cs" Inherits="Projeto.Pages.Cadastrar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">

        <!-- Card do formulário de cadastro -->
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div class="card p-3 w-100">
                    <div class="row">

                        <div class="col-md-3 mb-2">
                            <asp:Label CssClass="form-label" ID="labelNome" runat="server" Text="Nome:" />
                            <asp:TextBox CssClass="form-control" ID="txtNome" runat="server" />
                        </div>

                        <div class="col-md-3 mb-2">
                            <asp:Label CssClass="form-label" ID="labelMarcas" runat="server" Text="Marca:" />
                            <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select"
                                DataSourceID="Marcas" DataTextField="Nome" DataValueField="Id" />
                        </div>

                        <div class="col-md-3 mb-2">
                            <asp:Label CssClass="form-label" ID="labelQtd" runat="server" Text="Quantidade:" />
                            <asp:TextBox CssClass="form-control" ID="txtQtd" runat="server" />
                        </div>

                        <div class="col-md-3 mb-2">
                            <asp:Label CssClass="form-label" ID="labelCategoria" runat="server" Text="Categoria:" />
                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select"
                                DataSourceID="Categorias" DataTextField="Nome" DataValueField="Id" />
                        </div>

                        <div class="col-md-6 mb-2 d-flex align-items-center">
                          <asp:Button CssClass="btn btn-primary me-2" ID="bttSalvar" runat="server" Text="Cadastrar" OnClick="bttSalvar_Click" />
<asp:Button CssClass="btn btn-secondary" ID="bttCancelar" runat="server" Text="Cancelar" OnClick="bttCancelar_Click" />
                        </div>

                        <div class="col-md-12">
                            <asp:Label CssClass="form-label text-success" ID="lblMensagem" runat="server" />
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Card com o GridView de produtos -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card p-3">
                    <div class="card-header">
                        <strong>📦 Lista de Produtos</strong>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="GridProdutos" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="table table-striped text-center"
                            DataKeyNames="Id"
                            DataSourceID="Produtos"
                            ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="Nome" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditar" runat="server" CommandName="Edit" Text="✏️" ToolTip="Editar" />
                                        <asp:LinkButton ID="btnExcluir" runat="server" CommandName="Delete" Text="🗑️" ToolTip="Excluir" OnClientClick="return confirm('Tem certeza que deseja excluir?');" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="btnAtualizar" runat="server" CommandName="Update" Text="💾" ToolTip="Salvar" />
                                        <asp:LinkButton ID="btnCancelar" runat="server" CommandName="Cancel" Text="❌" ToolTip="Cancelar" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <!-- DataSources -->
        <asp:SqlDataSource runat="server" ID="Marcas"
            ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
            SelectCommand="SELECT Id, Nome FROM Marca" />

        <asp:SqlDataSource runat="server" ID="Categorias"
            ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
            SelectCommand="SELECT Id, Nome FROM Categorias" />

        <asp:SqlDataSource runat="server" ID="Produtos"
            ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
            SelectCommand="SELECT * FROM [Produtos] WHERE Ativo = 1"
            DeleteCommand="UPDATE [Produtos] SET Ativo = 0 WHERE Id = @Id"
            InsertCommand="INSERT INTO [Produtos] ([Nome], [Ativo]) VALUES (@Nome, 1)"
            UpdateCommand="UPDATE [Produtos] SET [Nome] = @Nome WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Nome" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nome" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </main>
</asp:Content>

