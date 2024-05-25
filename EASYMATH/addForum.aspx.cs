using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wappAssWebLearning.EASYMATH
{
    public partial class addForum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void postButton_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString);
                con.Open();

                // check the forum exist or not
                string query = "select count(*) from forumTable where forumTitle = '" + forumTopicTextBox.Text + "'";
                SqlCommand cmd = new SqlCommand(query, con);
                int check = Convert.ToInt32(cmd.ExecuteScalar().ToString());


                if (check > 0)
                {
                    errMsg.Visible = true;
                    errMsg.ForeColor = System.Drawing.Color.Red;
                    errMsg.Text = "Topic has been post!";
                }
                else
                {
                    string folderPath = Server.MapPath("~/forumImage/");
                    // Check if a file was uploaded
                    if (!Directory.Exists(folderPath))
                    {
                        // if it doesn't exist, create it's directory
                        Directory.CreateDirectory(folderPath);
                    }
                    // Get the name of the file to upload, and set it to be null if it doesn't upload'
                    string ImgPath = "";
                    if (this.fileUpload.HasFile)//to change profile picture
                    {                        
                        ImgPath = "~/forumImage/" + this.fileUpload.FileName.ToString();
                        //saving the photo to the file directory
                        fileUpload.SaveAs(folderPath + Path.GetFileName(fileUpload.FileName));
                    }
                    else
                    {
                        ImgPath = null;
                    }                    
                    
                    string query1 = "INSERT INTO forumTable (forumTitle, forumDescription, forumImage, forumDate, userName) VALUES (@Title, @Content, @Image, @Date, @UserName)";
                    SqlCommand cmd1 = new SqlCommand(query1, con);
                    cmd1.Parameters.AddWithValue("@Title", forumTopicTextBox.Text);
                    cmd1.Parameters.AddWithValue("@Content", forumContentTextBox.Text);
                    cmd1.Parameters.AddWithValue("@Date", DateTime.Now);
                    cmd1.Parameters.AddWithValue("@UserName", Session["userName"].ToString());

                    if (ImgPath != null)
                    {
                        cmd1.Parameters.AddWithValue("@Image", ImgPath);
                    }
                    else
                    {
                        cmd1.Parameters.AddWithValue("@Image", DBNull.Value);
                    }

                    cmd1.ExecuteNonQuery();
                    Response.Redirect("../EASYMATH/forum.aspx");

                }
                con.Close();
            }
            catch (Exception ex)
            {
                errMsg.Visible = true;
                errMsg.ForeColor = System.Drawing.Color.Red;
                errMsg.Text = "Forum is not posted!" + ex.ToString();
            }


        }
    }
}