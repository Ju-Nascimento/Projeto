using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Projeto.Pages
{
    public partial class Editar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CarregarCategorias();
                if (Session["Mensagem"] != null)
                {
                    lblMensagem.Text = Session["Mensagem"].ToString();
                    lblMensagem.CssClass = "text-success";
                    lblMensagem.Visible = true;
                    Session.Remove("Mensagem");
                }
            }
        }
        private void CarregarCategorias()
        {
            string query = "SELECT Id, Nome FROM Categorias WHERE Ativo = 1";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                DropCategorias.DataSource = dr;
                DropCategorias.DataTextField = "Nome";
                DropCategorias.DataValueField = "Id";
                DropCategorias.DataBind();
                DropCategorias.Items.Insert(0, new ListItem("Selecione...", ""));
            }
        }
        protected void DropCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropMarcas.Items.Clear();
            DropProdutos.Items.Clear();
            if (!string.IsNullOrEmpty(DropCategorias.SelectedValue))
            {
                int categoriaId = int.Parse(DropCategorias.SelectedValue);
                string query = @"SELECT DISTINCT m.Id, m.Nome 
                                 FROM Marca m
                                 INNER JOIN Produtos p ON m.Id = p.MarcaID
                                 WHERE p.CategoriaID = @CategoriaId AND m.Ativo = 1 AND p.Ativo = 1";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoriaId", categoriaId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    DropMarcas.DataSource = dr;
                    DropMarcas.DataTextField = "Nome";
                    DropMarcas.DataValueField = "Id";
                    DropMarcas.DataBind();
                    DropMarcas.Items.Insert(0, new ListItem("Selecione...", ""));
                }
            }
        }
        protected void DropMarcas_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropProdutos.Items.Clear();
            if (!string.IsNullOrEmpty(DropMarcas.SelectedValue) && !string.IsNullOrEmpty(DropCategorias.SelectedValue))
            {
                int marcaId = int.Parse(DropMarcas.SelectedValue);
                int categoriaId = int.Parse(DropCategorias.SelectedValue);
                string query = @"SELECT Id, Nome 
                                 FROM Produtos 
                                 WHERE MarcaID = @MarcaId AND CategoriaID = @CategoriaId AND Ativo = 1";
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MarcaId", marcaId);
                    cmd.Parameters.AddWithValue("@CategoriaId", categoriaId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    DropProdutos.DataSource = dr;
                    DropProdutos.DataTextField = "Nome";
                    DropProdutos.DataValueField = "Id";
                    DropProdutos.DataBind();
                    DropProdutos.Items.Insert(0, new ListItem("Selecione...", ""));
                }
            }
        }
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;
            if (string.IsNullOrEmpty(DropTipo.SelectedValue) ||
                string.IsNullOrEmpty(DropCategorias.SelectedValue) ||
                string.IsNullOrEmpty(DropMarcas.SelectedValue) ||
                string.IsNullOrEmpty(DropProdutos.SelectedValue) ||
                string.IsNullOrEmpty(txtQtd.Text))
            {
                lblMensagem.Text = "Preencha todos os campos.";
                lblMensagem.CssClass = "text-danger";
                lblMensagem.Visible = true;
                return;
            }
            int categoriaId = int.Parse(DropCategorias.SelectedValue);
            int marcaId = int.Parse(DropMarcas.SelectedValue);
            int produtoId = int.Parse(DropProdutos.SelectedValue);
            int qtd = int.Parse(txtQtd.Text);
            string tipo = DropTipo.SelectedValue;
            string conexao = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(conexao))
            {
                conn.Open();
                if (!string.IsNullOrEmpty(hfId.Value))
                {
                    string sqlUpdate = @"UPDATE Lancamentos 
                                         SET Tipo = @Tipo, CategoriaID = @CategoriaID, MarcaID = @MarcaID, ProdutoID = @ProdutoID, QTD = @QTD 
                                         WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(sqlUpdate, conn);
                    cmd.Parameters.AddWithValue("@Tipo", tipo);
                    cmd.Parameters.AddWithValue("@CategoriaID", categoriaId);
                    cmd.Parameters.AddWithValue("@MarcaID", marcaId);
                    cmd.Parameters.AddWithValue("@ProdutoID", produtoId);
                    cmd.Parameters.AddWithValue("@QTD", qtd);
                    cmd.Parameters.AddWithValue("@Id", int.Parse(hfId.Value));
                    cmd.ExecuteNonQuery();
                    Session["Mensagem"] = "✏️ Lançamento editado com sucesso!";
                }
                else
                {
                    string estoqueSql = tipo == "Entrada"
                        ? "UPDATE Produtos SET QTD = QTD + @Qtd WHERE Id = @ProdutoId"
                        : "UPDATE Produtos SET QTD = QTD - @Qtd WHERE Id = @ProdutoId";
                    using (SqlCommand cmdEstoque = new SqlCommand(estoqueSql, conn))
                    {
                        cmdEstoque.Parameters.AddWithValue("@Qtd", qtd);
                        cmdEstoque.Parameters.AddWithValue("@ProdutoId", produtoId);
                        if (tipo == "Saida")
                        {
                            SqlCommand verificarEstoque = new SqlCommand("SELECT QTD FROM Produtos WHERE Id = @ProdutoId", conn);
                            verificarEstoque.Parameters.AddWithValue("@ProdutoId", produtoId);
                            int qtdAtual = (int)verificarEstoque.ExecuteScalar();
                            if (qtd > qtdAtual)
                            {
                                lblMensagem.Text = $"Estoque insuficiente. Atual: {qtdAtual}.";
                                lblMensagem.CssClass = "text-danger";
                                lblMensagem.Visible = true;
                                return;
                            }
                        }
                        cmdEstoque.ExecuteNonQuery();
                    }
                    string insertSql = @"INSERT INTO Lancamentos (Tipo, CategoriaID, MarcaID, ProdutoID, QTD)
                                         VALUES (@Tipo, @CategoriaID, @MarcaID, @ProdutoID, @QTD)";
                    using (SqlCommand cmdLanc = new SqlCommand(insertSql, conn))
                    {
                        cmdLanc.Parameters.AddWithValue("@Tipo", tipo);
                        cmdLanc.Parameters.AddWithValue("@CategoriaID", categoriaId);
                        cmdLanc.Parameters.AddWithValue("@MarcaID", marcaId);
                        cmdLanc.Parameters.AddWithValue("@ProdutoID", produtoId);
                        cmdLanc.Parameters.AddWithValue("@QTD", qtd);
                        cmdLanc.ExecuteNonQuery();
                    }
                    Session["Mensagem"] = "✅ Lançamento registrado com sucesso!";
                }
            }
            Response.Redirect(Request.RawUrl);
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            hfId.Value = "";
            txtQtd.Text = "";
            DropTipo.ClearSelection();
            DropCategorias.ClearSelection();
            DropMarcas.Items.Clear();
            DropProdutos.Items.Clear();
        }
        protected void GridLancamentos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Excluir")
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Lancamentos SET Ativo = 0 WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect(Request.RawUrl);
            }
            if (e.CommandName == "Editar")
            {
                CarregarLancamentoParaEdicao(id);
            }
        }
        private void CarregarLancamentoParaEdicao(int id)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT Tipo, CategoriaID, MarcaID, ProdutoID, QTD 
                               FROM Lancamentos 
                               WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hfId.Value = id.ToString();
                    DropTipo.SelectedValue = reader["Tipo"].ToString();
                    DropCategorias.SelectedValue = reader["CategoriaID"].ToString();
                    DropCategorias_SelectedIndexChanged(null, null);
                    DropMarcas.SelectedValue = reader["MarcaID"].ToString();
                    DropMarcas_SelectedIndexChanged(null, null);
                    DropProdutos.SelectedValue = reader["ProdutoID"].ToString();
                    txtQtd.Text = reader["QTD"].ToString();
                }
            }
        }
    }
}
