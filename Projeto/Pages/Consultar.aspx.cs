using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Projeto.Pages
{
    public partial class Consultar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bttSalvar_Click(null, null); 
            }
        }
        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"SELECT p.Id, p.Nome, c.Nome AS Categoria, m.Nome AS Marca, p.QTD
                               FROM Produtos p
                               INNER JOIN Categorias c ON p.CategoriaID = c.Id
                               INNER JOIN Marca m ON p.MarcaID = m.Id
                               WHERE p.Ativo = 1 AND c.Ativo = 1 AND m.Ativo = 1";
                SqlCommand cmd = new SqlCommand();
                if (!string.IsNullOrEmpty(DropDownList1.SelectedValue))
                {
                    sql += " AND c.Id = @CategoriaId";
                    cmd.Parameters.AddWithValue("@CategoriaId", DropDownList1.SelectedValue);
                }
                if (!string.IsNullOrEmpty(DropDownList2.SelectedValue))
                {
                    sql += " AND m.Id = @MarcaId";
                    cmd.Parameters.AddWithValue("@MarcaId", DropDownList2.SelectedValue);
                }
                if (!string.IsNullOrEmpty(DropDownList3.SelectedValue))
                {
                    sql += " AND p.Id = @ProdutoId";
                    cmd.Parameters.AddWithValue("@ProdutoId", DropDownList3.SelectedValue);
                }
                cmd.CommandText = sql;
                cmd.Connection = con;
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Excluir")
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Produtos SET Ativo = 0 WHERE Id = @Id";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                bttSalvar_Click(null, null);
            }
            if (e.CommandName == "Editar")
            {
                CarregarProdutoParaEdicao(id);
            }
        }
        private void CarregarProdutoParaEdicao(int id)
        {
            CarregarCategorias();
            CarregarMarcas();
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = "SELECT Nome, QTD, CategoriaID, MarcaID FROM Produtos WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    hfId.Value = id.ToString();
                    txtNome.Text = reader["Nome"].ToString();
                    txtQtd.Text = reader["QTD"].ToString();
                    ddlCategoria.SelectedValue = reader["CategoriaID"].ToString();
                    ddlMarca.SelectedValue = reader["MarcaID"].ToString();
                    pnlEditar.Visible = true;
                }
            }
        }
        private void CarregarCategorias()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Nome FROM Categorias WHERE Ativo = 1", con);
                con.Open();
                ddlCategoria.DataSource = cmd.ExecuteReader();
                ddlCategoria.DataTextField = "Nome";
                ddlCategoria.DataValueField = "Id";
                ddlCategoria.DataBind();
            }
        }
        private void CarregarMarcas()
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT Id, Nome FROM Marca WHERE Ativo = 1", con);
                con.Open();
                ddlMarca.DataSource = cmd.ExecuteReader();
                ddlMarca.DataTextField = "Nome";
                ddlMarca.DataValueField = "Id";
                ddlMarca.DataBind();
            }
        }
        protected void btnSalvarEdicao_Click(object sender, EventArgs e)
        {
            int id = int.Parse(hfId.Value);
            string nome = txtNome.Text.Trim();
            int qtd = int.TryParse(txtQtd.Text, out int q) ? q : 0;
            int categoriaId = int.Parse(ddlCategoria.SelectedValue);
            int marcaId = int.Parse(ddlMarca.SelectedValue);
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"UPDATE Produtos 
                               SET Nome = @Nome, QTD = @QTD, CategoriaID = @CategoriaID, MarcaID = @MarcaID
                               WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Nome", nome);
                cmd.Parameters.AddWithValue("@QTD", qtd);
                cmd.Parameters.AddWithValue("@CategoriaID", categoriaId);
                cmd.Parameters.AddWithValue("@MarcaID", marcaId);
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            pnlEditar.Visible = false;
            bttSalvar_Click(null, null);
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            pnlEditar.Visible = false;
        }
    }
}
