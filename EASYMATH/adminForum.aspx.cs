using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using static wappAssWebLearning.EASYMATH.forum;
using System.IO;

namespace wappAssWebLearning.EASYMATH
{
    public partial class adminForum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindForumsFromDatabase();

            }
        }
        protected void bindForumsFromDatabase()
        {
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM forumTable", connect);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt != null && dt.Rows.Count > 0)
                {
                    forumTable.DataSource = dt;
                    forumTable.DataBind();
                }
                else
                {
                    // Add an empty row to the GridView to ensure it displays
                    dt.Rows.Add(dt.NewRow());
                    forumTable.DataSource = dt;
                    forumTable.DataBind();

                    // Hide the GridView headers
                    forumTable.Rows[0].Visible = false;
                }
            }
            Debug.WriteLine("datab binded");
        }

        protected void forumTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Debug.WriteLine("commaded accept");
            if (e.CommandName == "Edit")
            {
                // Convert the CommandArgument to an integer index
                int index = Convert.ToInt32(e.CommandArgument);
                forumTable.EditIndex = index;
                bindForumsFromDatabase();
            }
            else if (e.CommandName == "Remove")
            {
                // Convert the CommandArgument to an integer index
                int index = Convert.ToInt32(e.CommandArgument);
                forumTable_RowDeleting(sender, new GridViewDeleteEventArgs(index));
            }
        }

        protected void forumTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            forumTable.EditIndex = e.NewEditIndex;
            bindForumsFromDatabase();
        }

        protected void hiddenButton_Click(object sender, EventArgs e)
        {
            Debug.WriteLine("Hidden button clicked");
        }

        protected void forumTable_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = forumTable.Rows[e.RowIndex];
            int forumNo = Convert.ToInt32(forumTable.DataKeys[e.RowIndex].Value);

            TextBox forumTitle = (TextBox)row.FindControl("forumTitle");
            TextBox forumDescription = (TextBox)row.FindControl("forumDescription");
            HiddenField hiddenFieldForOriginalForumImage = (HiddenField)row.FindControl("hiddenFieldForOriginalForumImage");

            HiddenField hiddenForumImage = (HiddenField)row.FindControl("hiddenForumImage");
            string fileData = hiddenForumImage.Value;

            HiddenField hiddenFileName = (HiddenField)row.FindControl("hiddenFileName");  // New hidden field for file name
            string originalFileName = hiddenFileName.Value;  // Retrieve the original file name
            Debug.WriteLine("file data: " + fileData);
            Debug.WriteLine("original file name: " + originalFileName);


            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = @"UPDATE forumTable SET 
                        forumTitle = @forumTitle, 
                        forumDescription = @forumDescription, 
                        forumImage = @forumImage
                        WHERE forumNo = @forumNo";
                SqlCommand cmd = new SqlCommand(query, connect);
                cmd.Parameters.AddWithValue("@forumTitle", forumTitle.Text);
                cmd.Parameters.AddWithValue("@forumDescription", forumDescription.Text);

                // Handle Image Upload
                if (!string.IsNullOrEmpty(fileData))
                {
                    
                    string fileExtension = Path.GetExtension(originalFileName); // Get the original file extension
                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(originalFileName);
                    string uniqueFileName = $"{fileNameWithoutExtension}{fileExtension}";
                    string imgPath = "~/forumImages/" + uniqueFileName;

                    try
                    {
                        // Set the forum image path parameter
                        cmd.Parameters.AddWithValue("@forumImage", imgPath);

                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error saving image: " + ex.Message);
                    }
                }
                else
                {
                    // If no new image is uploaded, retain the existing image path
                    string existingImagePath = hiddenFieldForOriginalForumImage.Value;
                    cmd.Parameters.AddWithValue("@forumImage", existingImagePath);
                }


                cmd.Parameters.AddWithValue("@forumNo", forumNo);

                connect.Open();
                cmd.ExecuteNonQuery();
            }

            forumTable.EditIndex = -1;
            bindForumsFromDatabase();
        }

        protected void forumTable_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            forumTable.EditIndex = -1;
            bindForumsFromDatabase();
        }

        protected void forumTable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int forumNo = Convert.ToInt32(forumTable.DataKeys[e.RowIndex].Value);
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            try
            {
                Debug.WriteLine("deleting" + forumNo);
                using (SqlConnection connect = new SqlConnection(connString))
                {
                    string query = "DELETE FROM forumTable WHERE forumNo = @forumNo";
                    SqlCommand cmd = new SqlCommand(query, connect);
                    cmd.Parameters.AddWithValue("@forumNo", forumNo);

                    connect.Open();
                    cmd.ExecuteNonQuery();

                    string script = "alert('Successfully deleted this record');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", script, true);
                }
            }
            catch
            {
                Debug.WriteLine("cadelete" + forumNo);
                string script = "alert('Cannot delete. You should delete the comment in the forum first.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", script, true);
            }            

            bindForumsFromDatabase();
        }

    }
}