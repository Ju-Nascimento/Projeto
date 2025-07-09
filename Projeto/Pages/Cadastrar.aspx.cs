using System;
using System.Data.SqlClient;
using System.Web.UI;
namespace Projeto.Pages
{
    public partial class Cadastrar : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["Mensagem"] != null)
            {
                lblMensagem.Text = Session["Mensagem"].ToString();
                Session["Mensagem"] = null;
            }
        }
        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string nome = txtNome.Text;
            int marcaId = int.Parse(ddlMarca.SelectedValue);
            int categoriaId = int.Parse(ddlCategoria.SelectedValue);
            int qtd = int.Parse(txtQtd.Text);
            string conexao = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DB.mdf;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(conexao))
            {
                string sql = "INSERT INTO Produtos (Nome, MarcaID, CategoriaID, QTD) VALUES (@nome, @marca, @categoria, @qtd)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@nome", nome);
                cmd.Parameters.AddWithValue("@marca", marcaId);
                cmd.Parameters.AddWithValue("@categoria", categoriaId);
                cmd.Parameters.AddWithValue("@qtd", qtd);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    Session["Mensagem"] = "✅ Produto cadastrado com sucesso!";
                    Response.Redirect(Request.RawUrl); 
                }
                catch (Exception ex)
                {
                    lblMensagem.Text = "❌ Erro ao cadastrar: " + ex.Message;
                }
            }
        }
        protected void bttCancelar_Click(object sender, EventArgs e)
        {
            LimparCampos();
            lblMensagem.Text = ""; 
        }
        public void LimparCampos()
        {
            txtNome.Text = "";
            ddlMarca.SelectedIndex = 0;
            ddlCategoria.SelectedIndex = 0;
            txtQtd.Text = "";
        }
    }
}
