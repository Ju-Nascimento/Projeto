<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Consultar.aspx.cs" Inherits="Projeto.Pages.Consultar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-12">
                <div id="consultas" class="container m-3">
                    <div class="card p-3 mb-4">
                    <div class="row align-items-center gx-3 ">

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
                                SelectCommand="SELECT Id, Nome FROM Categorias WHERE Ativo = 1" />
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
                                SelectCommand="SELECT Id, Nome FROM Marca WHERE Ativo = 1" />
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
                                SelectCommand="SELECT Id, Nome FROM Produtos WHERE Ativo = 1" />
                        </div>

                        <!-- Botões -->
                        <div class="col-md-3 d-flex gap-2">
                            <asp:Button ID="bttSalvar" runat="server" Text="Consultar" CssClass="btn btn-primary" OnClick="bttSalvar_Click" />
                            <asp:Button ID="Button2" runat="server" Text="Cancelar" CssClass="btn btn-secondary" />
                        </div>
                    </div>
                        </div>
                    <!-- Grid de resultados -->
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <asp:GridView ID="GridView1" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table table-bordered table-striped"
                                DataKeyNames="Id"
                                OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="Nome" HeaderText="Produto" />
                                    <asp:BoundField DataField="Categoria" HeaderText="Categoria" />
                                    <asp:BoundField DataField="Marca" HeaderText="Marca" />
                                    <asp:BoundField DataField="QTD" HeaderText="Estoque" />
                                    <asp:TemplateField HeaderText="Ações">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar" CommandArgument='<%# Eval("Id") %>' Text="✏️" ToolTip="Editar" />
                                            <asp:LinkButton ID="btnExcluir" runat="server" CommandName="Excluir" CommandArgument='<%# Eval("Id") %>' Text="🗑️" ToolTip="Excluir" OnClientClick="return confirm('Deseja realmente excluir?');" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="col-12 d-flex justify-content-center">
                                <asp:Panel ID="pnlEditar" runat="server" CssClass="card p-3 mt-3 w-100" Visible="false">
                                    <h5 class="mb-3">Editar Produto</h5>
                                    <asp:HiddenField ID="hfId" runat="server" />

                                    <div class="row">
                                        <div class="col-md-2 mb-2">
                                            <label>Produto:</label>
                                            <asp:TextBox ID="txtNome" runat="server" CssClass="form-control" />
                                        </div>
                                        <div class="col-md-3 mb-2">
                                            <label>Categoria:</label>
                                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control" />
                                        </div>

                                        <div class="col-md-3 mb-2">
                                            <label>Marca:</label>
                                            <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-control" />
                                        </div>

                                        <div class="col-md-2 mb-2">
                                            <label>Estoque:</label>
                                            <asp:TextBox ID="txtQtd" runat="server" CssClass="form-control" />
                                        </div>


                                    </div>

                                    <div class="row mt-2">
                                        <div class="col-md-12 text-end">
                                            <asp:Button ID="btnSalvarEdicao" runat="server" Text="Salvar" CssClass="btn btn-success me-2" OnClick="btnSalvarEdicao_Click" />
                                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>



                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>
</asp:Content>
