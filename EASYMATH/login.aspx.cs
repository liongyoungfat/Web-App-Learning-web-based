using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webAssignment.EASYMATH
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
 
           string userName = txtUsername.Text;
           string password = txtPassword.Text;
           string query = "";
           string userType = "";

            var isValid = validateInputFields();

            if (!isValid)
            {
                return;
            }

            userType = userName.Substring(0, 2);

           if (userType == "ST")
           {
              query = "SELECT COUNT(*) FROM studTable WHERE userName = @username AND password = @password";
           }
           else if (userType == "TE")
           {
              query = "SELECT COUNT(*) FROM teachTable WHERE userName = @username AND password = @password";
           }
           else if (userType == "AD")
           {
              query = "SELECT COUNT(*) FROM adminTable WHERE userName = @username AND password = @password";
           }
           else
           {
                UsernameError1.Visible = true;
                UsernameError1.ForeColor = System.Drawing.Color.Red;
                UsernameError1.Text = "Invalid Username!";
                txtUsername.Text = "";
                return;
           }

            try
            {
                SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString);
                connect.Open();

                SqlCommand cmd1 = new SqlCommand(query, connect);
                cmd1.Parameters.AddWithValue("@username", userName);
                cmd1.Parameters.AddWithValue("@password", password);
                int count = Convert.ToInt32(cmd1.ExecuteScalar());

                if (count > 0)
                {
                    // Redirect the user to their respective page
                    if (userType == "ST")
                    {
                        Response.Redirect("~/EASYMATH/studentDashboard.aspx");
                    }
                    else if (userType == "TE")
                    {
                        Response.Redirect("~/EASYMATH/teacherDashboard.aspx");
                    }
                    else if (userType == "AD")
                    {
                        Response.Redirect("~/EASYMATH/adminDashboard.aspx");
                    }
                    else
                    {
                       
                    }
                }

                UsernameAPasswordError.Visible = true;
                UsernameAPasswordError.ForeColor = System.Drawing.Color.Red;
                UsernameAPasswordError.Text = "Invalid Username or Password!";
                txtUsername.Text = "";
                txtPassword.Text = "";
            }
            catch (Exception ex)
            {
                LoginError.Visible = true;
                LoginError.ForeColor = System.Drawing.Color.Red;
                LoginError.Text = "Login Unsuccessful. Please try again!" + ex.ToString();
            }
        }
        private bool validateInputFields()
        {
            bool isValid = true;

            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                isValid = false;
                UsernameError.Visible = true;
                UsernameError.ForeColor = System.Drawing.Color.Red;
                UsernameError.Text = "Username is required!";
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                isValid = false;
                PasswordError.Visible = true;
                PasswordError.ForeColor = System.Drawing.Color.Red;
                PasswordError.Text = "Password is required!";
            }

            return isValid;
        }

        protected void btnResetCredentials_Click(object sender, EventArgs e)
        {
            Response.Redirect("../EASYMATH/resetCredentials.aspx");
        }

    }
}