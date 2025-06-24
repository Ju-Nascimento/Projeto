<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Projeto._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">ASP.NET</h1>
            <p class="lead">Sistema de gerenciamento de Estoque </p>

        </section>

        <div class="row">
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2>Cadastrar Produtos</h2>
                <p>
                    Cadastrar produtos no Banco de Dados
                </p>
                <p>
                    <a class="btn btn-primary btn-md" href="Pages/Cadastrar.aspx">Cadastrar &raquo;</a>
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="librariesTitle">
                <h2 id="librariesTitle">Consultar Estoque</h2>
                <p>
                    Consultar Produtos no Banco de Dados
                </p>
                <p>
                    <a class="btn btn-primary btn-md" href="Pages/Consultar.aspx">Estoque &raquo;</a>
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <h2>Lançamentos de Produtos</h2>
                <p>
                   Registrar a saída de itens do estoque no sistema.
                </p>
                <p>
                    <a class="btn btn-primary btn-md" href="Pages/Lancamentos.aspx">Lançamento &raquo;</a>
                </p>
            </section>
        </div>
    </main>

</asp:Content>
