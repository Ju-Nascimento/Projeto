using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
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
            }
        }

        private void CarregarCategorias()
        {
            string query = "SELECT Id, Nome FROM Categorias";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                DropDownList1.DataSource = dr;
                DropDownList1.DataTextField = "Nome";
                DropDownList1.DataValueField = "Id";
                DropDownList1.DataBind();

                DropDownList1.Items.Insert(0, new ListItem("Selecione uma categoria", ""));
            }
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList2.Items.Clear();
            DropDownList3.Items.Clear();

            if (!string.IsNullOrEmpty(DropDownList1.SelectedValue))
            {
                int categoriaId = int.Parse(DropDownList1.SelectedValue);

                string query = @"SELECT DISTINCT m.Id, m.Nome 
                         FROM Marca m
                         INNER JOIN Produtos p ON m.Id = p.MarcaID
                         WHERE p.CategoriaID = @CategoriaId";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CategoriaId", categoriaId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    DropDownList2.DataSource = dr;
                    DropDownList2.DataTextField = "Nome";
                    DropDownList2.DataValueField = "Id";
                    DropDownList2.DataBind();
                    DropDownList2.Items.Insert(0, new ListItem("Selecione uma marca", ""));
                }
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList3.Items.Clear();

            if (!string.IsNullOrEmpty(DropDownList2.SelectedValue) && !string.IsNullOrEmpty(DropDownList1.SelectedValue))
            {
                int marcaId = int.Parse(DropDownList2.SelectedValue);
                int categoriaId = int.Parse(DropDownList1.SelectedValue);

                string query = @"SELECT Id, Nome, Preco 
                         FROM Produtos 
                         WHERE MarcaID = @MarcaId AND CategoriaID = @CategoriaId";

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MarcaId", marcaId);
                    cmd.Parameters.AddWithValue("@CategoriaId", categoriaId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        ListItem item = new ListItem(dr["Nome"].ToString(), dr["Id"].ToString());
                        item.Attributes["data-preco"] = Convert.ToDecimal(dr["Preco"]).ToString("F2");
                        DropDownList3.Items.Add(item);
                    }

                    DropDownList3.Items.Insert(0, new ListItem("Selecione um produto", ""));
                }
            }
        }
        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            lblMensagem.Visible = false;  // sempre esconde no começo

            if (string.IsNullOrEmpty(DropDownList3.SelectedValue) || string.IsNullOrEmpty(TextBox1.Text))
            {
                lblMensagem.Text = "Por favor, selecione um produto e informe a quantidade.";
                lblMensagem.CssClass = "text-danger";
                lblMensagem.Visible = true;
                return;
            }

            int produtoId = int.Parse(DropDownList3.SelectedValue);
            int quantidadeVendida;

            if (!int.TryParse(TextBox1.Text, out quantidadeVendida) || quantidadeVendida <= 0)
            {
                lblMensagem.Text = "Informe uma quantidade válida.";
                lblMensagem.CssClass = "text-danger";
                lblMensagem.Visible = true;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string selectQuery = "SELECT QTD FROM Produtos WHERE Id = @ProdutoId";
                SqlCommand selectCmd = new SqlCommand(selectQuery, conn);
                selectCmd.Parameters.AddWithValue("@ProdutoId", produtoId);

                int qtdAtual = (int)selectCmd.ExecuteScalar();

                if (quantidadeVendida > qtdAtual)
                {
                    lblMensagem.Text = $"Estoque insuficiente. Estoque atual: {qtdAtual}.";
                    lblMensagem.CssClass = "text-danger";
                    lblMensagem.Visible = true;
                    return;
                }

                string updateQuery = "UPDATE Produtos SET QTD = QTD - @QtdVendida WHERE Id = @ProdutoId";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@QtdVendida", quantidadeVendida);
                updateCmd.Parameters.AddWithValue("@ProdutoId", produtoId);

                updateCmd.ExecuteNonQuery();
            }

            lblMensagem.Text = "Venda registrada com sucesso!";
            lblMensagem.CssClass = "text-success";
            lblMensagem.Visible = true;

            // Limpar controles
            TextBox1.Text = "";
            TextBox2.Text = "";
            DropDownList1.ClearSelection();
            DropDownList2.Items.Clear();
            DropDownList3.Items.Clear();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            DropDownList1.ClearSelection();
            DropDownList2.Items.Clear();
            DropDownList3.Items.Clear();
        }
    }
}
        
    