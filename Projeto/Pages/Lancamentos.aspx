<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lancamentos.aspx.cs" Inherits="Projeto.Pages.Editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container m-4">
        <div class="row">
            <div class="col-md-6">

                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="Label1" runat="server" Text="Categoria:"></asp:Label>
                    <asp:DropDownList 
                        ID="DropDownList1" 
                        runat="server" 
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" 
                        CssClass="form-select">
                    </asp:DropDownList>
                </div>

                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="Label2" runat="server" Text="Marca:"></asp:Label>
                    <asp:DropDownList 
                        ID="DropDownList2" 
                        runat="server" 
                        AutoPostBack="true" 
                        OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" 
                        CssClass="form-select">
                    </asp:DropDownList>
                </div>

                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="Label3" runat="server" Text="Produto:"></asp:Label>
                    <asp:DropDownList 
                        ID="DropDownList3" 
                        runat="server" 
                        CssClass="form-select">
                    </asp:DropDownList>
                </div>

                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="Label4" runat="server" Text="Quantidade:"></asp:Label>
                    <asp:TextBox 
                        ID="TextBox1" 
                        runat="server" 
                        CssClass="form-control">
                    </asp:TextBox>
                </div>

                <div class="mb-2">
                    <asp:Label CssClass="form-label" ID="Label5" runat="server" Text="Subtotal:"></asp:Label>
                    <asp:TextBox 
                        ID="TextBox2" 
                        runat="server" 
                        CssClass="form-control" 
                        ReadOnly="true">
                    </asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Button 
                        ID="btnConfirmar" 
                        runat="server" 
                        Text="Confirmar" 
                        OnClick="btnConfirmar_Click" 
                        CssClass="btn btn-primary" />
                    <asp:Button 
                        ID="Button2" 
                        runat="server" 
                        Text="Cancelar" 
                        CssClass="btn btn-secondary ms-2"
                        onclick="Button2_Click"/>
                </div>

                <asp:Label 
                    ID="lblMensagem" 
                    runat="server" 
                    CssClass="form-label text-success" 
                    Visible="false">
                </asp:Label>

            </div>
        </div>
    </main>

   <script>
       function atualizarSubtotal() {
           var ddlProdutos = document.getElementById('<%= DropDownList3.ClientID %>');
        var txtQtd = document.getElementById('<%= TextBox1.ClientID %>');
        var txtSubtotal = document.getElementById('<%= TextBox2.ClientID %>');

        var selectedOption = ddlProdutos.options[ddlProdutos.selectedIndex];
        var preco = parseFloat(selectedOption.getAttribute("data-preco").replace(',', '.')) || 0;
        var qtd = parseFloat(txtQtd.value.replace(',', '.')) || 0;

        var subtotal = preco * qtd;
        txtSubtotal.value = subtotal.toFixed(2);
    }

    window.onload = function () {
        document.getElementById('<%= DropDownList3.ClientID %>').addEventListener('change', atualizarSubtotal);
        document.getElementById('<%= TextBox1.ClientID %>').addEventListener('input', atualizarSubtotal);
       };
</script>


</asp:Content>
