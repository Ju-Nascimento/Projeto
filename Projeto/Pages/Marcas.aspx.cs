using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Projeto.Pages
{
    public partial class Marcas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["lblMensagem"] == "sucesso")
                {
                    lblMensagem.Text = "✅ Cadastrado feito com sucesso!";
                }
        }
        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string marca = txtMarca.Text;
            string conexao = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DB.mdf;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(conexao))
            {
                string sql = "INSERT INTO Marca (Nome) VALUES (@marca)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@marca", marca);
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    txtMarca.Text = " ";
                    GridMarcas.DataBind();
                    Response.Redirect(Request.RawUrl + "?lblMensagem=sucesso");
                }
                catch(Exception ex) {
                    lblMensagem.Text = ex.Message;
                }
            }
        }
        protected void bttCancelar_Click(object sender, EventArgs e)
        {
        }
    }
}