using System;
using System.Collections.Generic;
using System.Configuration.Provider;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Projeto.Pages
{
    public partial class Categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["msg"] == "sucesso")
            {
                msg.Text = "✅ Cadastrado feito com sucesso!";
            }
        }
        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string categoria = txtCategoria.Text;
            string conexao = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\DB.mdf;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(conexao))
            {
                string sql = "INSERT INTO Categorias (Nome) VALUES (@categoria)";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@categoria", categoria);
                try { 
                    con.Open();
                    cmd.ExecuteNonQuery();
                    txtCategoria.Text = "";
                    GridView1.DataBind();
                    Response.Redirect(Request.RawUrl + "?msg=sucesso");
                }
                catch (Exception ex)
                {
                    msg.Text = ex.Message;
                }
            }
        }
        protected void bttCancelar_Click(object sender, EventArgs e)
        {
            txtCategoria.Text = "";
        }
    }
}