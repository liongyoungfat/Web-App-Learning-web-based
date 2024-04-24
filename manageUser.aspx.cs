using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Lab06
{
    public partial class manageUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["firstName"] != null)
            {
                usernameLabel.Text = "Hi," + Session["firstName"].ToString();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString);
            con.Open();

            if (!Page.IsPostBack)
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from userTable where usertype = '" + usertypeLabel.Text + "'", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                uname.DataSource = dt;
                uname.DataTextField = "username";
                DataBind();
            }

        }
    }
}
