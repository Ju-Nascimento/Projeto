<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Consultar.aspx.cs" Inherits="Projeto.Pages.Consultar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-6">
               <div id="consultas" class="container m-3">
  <div class="row align-items-center gx-3">

    <div class="col-md-3 d-flex align-items-center">
      <asp:Label CssClass="form-label me-2 mb-0" ID="Label1" runat="server" Text="Categoria:"></asp:Label>
      <asp:DropDownList CssClass="form-select" ID="DropDownList1" runat="server"></asp:DropDownList>
    </div>

    <div class="col-md-3 d-flex align-items-center">
      <asp:Label CssClass="form-label me-2 mb-0" ID="Label2" runat="server" Text="Marca:"></asp:Label>
      <asp:DropDownList CssClass="form-select" ID="DropDownList2" runat="server"></asp:DropDownList>
    </div>

    <div class="col-md-3 d-flex align-items-center">
      <asp:Label CssClass="form-label me-2 mb-0" ID="Label3" runat="server" Text="Produto:"></asp:Label>
      <asp:DropDownList CssClass="form-select" ID="DropDownList3" runat="server"></asp:DropDownList>
    </div>

    <div class="col-md-3 d-flex gap-2">
      <asp:Button ID="Button1" runat="server" Text="Consultar" CssClass="btn btn-primary" />
      <asp:Button ID="Button2" runat="server" Text="Cancelar" CssClass="btn btn-secondary" />
    </div>

  </div>
</div>


                <div class="col-md-2">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                        CssClass="table table-striped"
                        AutoGenerateColumns="False" DataKeyNames="Id" AllowSorting="True"
                        ShowHeaderWhenEmpty="True" EmptyDataText="Nenhum produto cadastrado no momento.">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True"></asp:CommandField>
                            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" SortExpression="Id"></asp:BoundField>
                            <asp:BoundField DataField="Nome" HeaderText="Nome" SortExpression="Nome"></asp:BoundField>
                            <asp:BoundField DataField="Quantidade" HeaderText="Quantidade" SortExpression="Quantidade"></asp:BoundField>
                            <asp:BoundField DataField="Preco" HeaderText="Preco" SortExpression="Preco"></asp:BoundField>
                            <asp:BoundField DataField="Categoria" HeaderText="Categoria" SortExpression="Categoria"></asp:BoundField>
                            <asp:BoundField DataField="Marca" HeaderText="Marca" SortExpression="Marca"></asp:BoundField>
                        </Columns>
                    </asp:GridView >
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Produtos]" DeleteCommand="DELETE FROM [Produtos] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Produtos] ([Nome], [Quantidade], [Preco], [Categoria], [Marca]) VALUES (@Nome, @Quantidade, @Preco, @Categoria, @Marca)" UpdateCommand="UPDATE [Produtos] SET [Nome] = @Nome, [Quantidade] = @Quantidade, [Preco] = @Preco, [Categoria] = @Categoria, [Marca] = @Marca WHERE [Id] = @Id">
                        <DeleteParameters>
                            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Nome" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Quantidade" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="Preco" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="Categoria" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Marca" Type="String"></asp:Parameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Nome" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Quantidade" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="Preco" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="Categoria" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Marca" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>

    </main>
</asp:Content>
