<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="Projeto.Pages.Marcas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container mt-4">
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div class="card p-3 w-100">
                    <div class="row">
                        <div class="col-md-6 mb-2 d-flex align-items-center">
                            <asp:Label CssClass="form-label me-2 mb-0" ID="lblMarca" runat="server" Text="Nova Marca:" />
                            <asp:TextBox CssClass="form-control me-2" ID="txtMarca" runat="server" />
                        </div>
                        <div class="col-md-6 mb-2 d-flex align-items-center">
                            <asp:Button CssClass="btn btn-primary me-2" ID="bttSalvar" runat="server" Text="Cadastrar" OnClick="bttSalvar_Click" />
                            <asp:Button CssClass="btn btn-secondary" ID="bttCancelar" runat="server" Text="Cancelar" OnClick="bttCancelar_Click" />
                        </div>
                        <div class="col-md-12">
                            <asp:Label CssClass="form-text text-success" ID="lblMensagem" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-12">
                <div class="card p-3">
                    <div class="card-header">
                        <strong>📋 Lista de Marcas</strong>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="GridMarcas" runat="server"
                            CssClass="table table-bordered table-striped text-center"
                            AutoGenerateColumns="False"
                            DataSourceID="Grid_Marcas"
                            ShowHeader="False"
                            DataKeyNames="Id">
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
        <asp:SqlDataSource runat="server" ID="Grid_Marcas"
            ConnectionString='<%$ ConnectionStrings:ConnectionString %>'
            SelectCommand="SELECT * FROM [Marca] WHERE Ativo = 1"
            DeleteCommand="UPDATE [Marca] SET Ativo = 0 WHERE Id = @Id"
            InsertCommand="INSERT INTO [Marca] ([Nome], [Ativo]) VALUES (@Nome, 1)"
            UpdateCommand="UPDATE [Marca] SET [Nome] = @Nome WHERE [Id] = @Id">
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
