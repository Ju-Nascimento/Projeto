using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Projeto.Pages
{
    public partial class Cadastrar : Page
    {
        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string nome = txtNome.Text;
            int marcaId = int.Parse(ddlMarca.SelectedValue);
            int categoriaId = int.Parse(ddlCategoria.SelectedValue);
            decimal preco = decimal.Parse(txtPreco.Text);
            int qtd = int.Parse(txtQtd.Text);

            string conexao = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DB.mdf;Integrated Security=True";

            using (SqlConnection con = new SqlConnection(conexao))
            {
                string sql = "INSERT INTO Produtos (Nome, MarcaID, CategoriaID, Preco, QTD) VALUES (@nome, @marca, @categoria, @preco, @qtd)";
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@nome", nome);
                cmd.Parameters.AddWithValue("@marca", marcaId);
                cmd.Parameters.AddWithValue("@categoria", categoriaId);
                cmd.Parameters.AddWithValue("@preco", preco);
                cmd.Parameters.AddWithValue("@qtd", qtd);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMensagem.Text = "✅ Produto cadastrado com sucesso!";
                    LimparCampos();
                }
                catch (Exception ex)
                {
                    lblMensagem.Text = "❌ Erro ao cadastrar: " + ex.Message;
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            LimparCampos();
            lblMensagem.Text = ""; // limpa a mensagem também
        }

        public void LimparCampos()
        {
            txtNome.Text = "";
            ddlMarca.SelectedIndex = 0;
            ddlCategoria.SelectedIndex = 0;
            txtPreco.Text = "";
            txtQtd.Text = "";
        }
    }
}
