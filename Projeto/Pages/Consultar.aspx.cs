using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projeto.Pages
{
    public partial class Consultar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bttSalvar_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Monta a base do SQL com INNER JOINs para trazer nomes de Marca e Categoria
                string sql = @"
    SELECT P.Id, P.Nome, C.Nome AS Categoria, M.Nome AS Marca, P.Preco, P.QTD
    FROM Produtos P
    INNER JOIN Categorias C ON P.CategoriaID = C.Id
    INNER JOIN Marca M ON P.MarcaID = M.Id
    WHERE 1 = 1";

                // Montagem dinâmica de filtros
                SqlCommand cmd = new SqlCommand();
                if (!string.IsNullOrEmpty(DropDownList1.SelectedValue))
                {
                    sql += " AND C.Id = @CategoriaId";
                    cmd.Parameters.AddWithValue("@CategoriaId", DropDownList1.SelectedValue);
                }

                if (!string.IsNullOrEmpty(DropDownList2.SelectedValue))
                {
                    sql += " AND M.Id = @MarcaId";
                    cmd.Parameters.AddWithValue("@MarcaId", DropDownList2.SelectedValue);
                }

                if (!string.IsNullOrEmpty(DropDownList3.SelectedValue))
                {
                    sql += " AND P.Id = @ProdutoId";
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

    }

}