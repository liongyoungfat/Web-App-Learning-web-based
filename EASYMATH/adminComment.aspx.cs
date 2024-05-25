using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wappAssWebLearning.EASYMATH
{
    public partial class adminComment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindCommentsFromDatabase();
            }
        }
        protected void bindCommentsFromDatabase()
        {
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM commentTable", connect);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt != null && dt.Rows.Count > 0)
                {
                    commentTable.DataSource = dt;
                    commentTable.DataBind();
                }
                else
                {
                    // Add an empty row to the GridView to ensure it displays
                    dt.Rows.Add(dt.NewRow());
                    commentTable.DataSource = dt;
                    commentTable.DataBind();

                    // Hide the GridView headers
                    commentTable.Rows[0].Visible = false;
                }
            }
            Debug.WriteLine("datab binded");
        }



        protected void commentTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Debug.WriteLine("commaded accept");
            if (e.CommandName == "Edit")
            {
                // Convert the CommandArgument to an integer index
                int index = Convert.ToInt32(e.CommandArgument);
                commentTable.EditIndex = index;
                bindCommentsFromDatabase();
            }
            else if (e.CommandName == "Remove")
            {
                // Convert the CommandArgument to an integer index
                int index = Convert.ToInt32(e.CommandArgument);
                commentTable_RowDeleting(sender, new GridViewDeleteEventArgs(index));
            }
        }

        protected void commentTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            commentTable.EditIndex = e.NewEditIndex;
            bindCommentsFromDatabase();
        }

        protected void hiddenButton_Click(object sender, EventArgs e)
        {
            Debug.WriteLine("Hidden button clicked");
        }


        protected void commentTable_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = commentTable.Rows[e.RowIndex];
            int commentNo = Convert.ToInt32(commentTable.DataKeys[e.RowIndex].Value);

            TextBox commentDescription = (TextBox)row.FindControl("commentDescription");
            HiddenField hiddenFieldForOriginalCommentImage = (HiddenField)row.FindControl("hiddenFieldForOriginalCommentImage");

            HiddenField hiddenCommentImage = (HiddenField)row.FindControl("hiddenCommentImage");
            string fileData = hiddenCommentImage.Value;

            HiddenField hiddenFileName = (HiddenField)row.FindControl("hiddenFileName");  // hidden field for file name
            string originalFileName = hiddenFileName.Value;  // retrieve the original file name as what user has input
            Debug.WriteLine("file data: " + fileData);
            Debug.WriteLine("original file name: " + originalFileName);


            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = @"UPDATE commentTable SET                
                commentDescription = @commentDescription, 
                commentImage = @commentImage
                WHERE commentNo = @commentNo";
                SqlCommand cmd = new SqlCommand(query, connect);
                cmd.Parameters.AddWithValue("@commentDescription", commentDescription.Text);

                // Handle Image Upload
                try
                {                  

                    if (!string.IsNullOrEmpty(fileData))
                    {
                        
                        string fileExtension = Path.GetExtension(originalFileName); // Get the original file extension
                        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(originalFileName);
                        string uniqueFileName = $"{fileNameWithoutExtension}{fileExtension}";
                        string imgPath = "~/commentImages/" + uniqueFileName;

                        try
                        {
                            // Set the forum image path parameter
                            cmd.Parameters.AddWithValue("@commentImage", imgPath);

                        }
                        catch (Exception ex)
                        {
                            Debug.WriteLine("Error saving image: " + ex.Message);
                        }
                    }
                    else
                    {
                        // If no new image is uploaded, retain the existing image path                    
                        string existingImagePath = hiddenFieldForOriginalCommentImage.Value;
                        cmd.Parameters.AddWithValue("@commentImage", existingImagePath);
                    }
                }
                catch
                {

                }               


                cmd.Parameters.AddWithValue("@commentNo", commentNo);

                connect.Open();
                cmd.ExecuteNonQuery();
            }

            commentTable.EditIndex = -1;
            bindCommentsFromDatabase();
        }


        protected void commentTable_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            commentTable.EditIndex = -1;
            bindCommentsFromDatabase();
        }

        protected void commentTable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int commentNo = Convert.ToInt32(commentTable.DataKeys[e.RowIndex].Value);
            Debug.WriteLine("deleting" + commentNo);
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = "DELETE FROM commentTable WHERE commentNo = @commentNo";
                SqlCommand cmd = new SqlCommand(query, connect);
                cmd.Parameters.AddWithValue("@commentNo", commentNo);

                connect.Open();
                cmd.ExecuteNonQuery();

                string script = "alert('Successfully deleted this record');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", script, true);
            }

            bindCommentsFromDatabase();
        }
    }
}