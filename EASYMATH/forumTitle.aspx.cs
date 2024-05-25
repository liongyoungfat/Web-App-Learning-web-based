using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Net.NetworkInformation;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using static wappAssWebLearning.EASYMATH.forumTitle;

namespace wappAssWebLearning.EASYMATH
{
    public partial class forumTitle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int forumNo;
                if (int.TryParse(Request.QueryString["forumNo"], out forumNo))
                {
                    loadForumDetails(forumNo);  //for the headings of comment
                    getCommentsFromDatabase(forumNo); //comments for the specific forum
                }                
                
            }

        }



        private void loadForumDetails(int forumNo)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["myConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT forumNo, forumTitle, forumDescription,forumImage, forumDate, userName FROM forumTable WHERE forumNo = @forumNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@forumNo", forumNo);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        labelForumTitle.Text = reader["forumTitle"].ToString();
                        forumImage.ImageUrl = reader["forumImage"].ToString();
                        labelForumDescription.Text = reader["forumDescription"].ToString();
                        labelForumDate.Text = ((DateTime)reader["forumDate"]).ToString("dd MMM yyyy");
                        labelTeachUserName.Text = reader["userName"].ToString();

                        // Set the visibility based on whether the ImageUrl is NULL or not
                        forumImage.Visible = !string.IsNullOrEmpty(forumImage.ImageUrl);
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
        }

        private List<Comment> getCommentsFromDatabase(int forumNo)
        {
            List<Comment> comments = new List<Comment>();
            string connectionString = WebConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT commentDescription, commentDate, commentImage, commentNo, userName FROM commentTable WHERE forumNo = @forumNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@forumNo", forumNo);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Comment comment = new Comment
                        {
                            commentDescription = reader["commentDescription"].ToString(),
                            commentImage = reader["commentImage"].ToString(),
                            commentNo = int.Parse(reader["commentNo"].ToString()),                           
                            commentDate = (DateTime)reader["commentDate"],                            
                            userName = reader["userName"].ToString()
                        };
                        comments.Add(comment);
                        rptComments.DataSource = comments;
                        rptComments.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
            return comments;
        }

        public class Comment
        {
            public string commentDescription { get; set; }
            public DateTime commentDate { get; set; }
            public string commentImage { get; set; }
            public string userName { get; set; }
            public int commentNo { get; set; }
        }



        protected void addCommentButton_Click(object sender, EventArgs e)
        {
            commentTextBox.Visible = true;
            commentFileUpload.Visible = true;
            postCommentButton.Visible = true;
            addCommentButton.Visible = false;
        }

        protected void postComment_Click(object sender, EventArgs e)
        {

            int forumNo;

            if (int.TryParse(Request.QueryString["forumNo"], out forumNo))
            {
                Debug.WriteLine("forumNo");
                commentTextBox.Visible = true;
                commentFileUpload.Visible = true;

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString);
                con.Open();
                string query = "INSERT INTO commentTable (commentDescription, commentImage, commentDate, forumNo, userName) VALUES (@commentDescription, @commentImage, @commentDate, @forumNo, @userName)";
                SqlCommand cmd = new SqlCommand(query, con);

                string folderPath = Server.MapPath("~/commentImage/");
                // Check if a file was uploaded
                if (!Directory.Exists(folderPath))
                {
                    // if it doesn't exist, create it's directory
                    Directory.CreateDirectory(folderPath);
                }
                // Get the name of the file to upload, and set it to be null if it doesn't upload'
                string ImgPath = "";
                if (this.commentFileUpload.HasFile)//to change profile picture
                {

                    ImgPath = "~/commentImage/" + this.commentFileUpload.FileName.ToString();
                    //saving the photo to the file directory
                    commentFileUpload.SaveAs(folderPath + Path.GetFileName(commentFileUpload.FileName));
                }
                else
                {
                    ImgPath = null;
                }

                cmd.Parameters.AddWithValue("@commentDescription", commentTextBox.Text);
                cmd.Parameters.AddWithValue("@commentDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@forumNo", forumNo);
                cmd.Parameters.AddWithValue("@userName", Session["userName"].ToString());

                if (ImgPath != null)
                {
                    cmd.Parameters.AddWithValue("@commentImage", ImgPath);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@commentImage", DBNull.Value);
                }

                cmd.ExecuteNonQuery();
                bindDatabase(forumNo);
                commentTextBox.Visible = false;
                commentFileUpload.Visible = false;
                postCommentButton.Visible = false;
                addCommentButton.Visible = true;
            }
        }


        protected void editCommentButton_Click(object sender, EventArgs e)
        {
            Button editButton = (Button)sender;
            int commentNo = int.Parse(editButton.CommandArgument);

            // Find the Repeater Item
            RepeaterItem item = (RepeaterItem)editButton.NamingContainer;

            // Hide the labels and show the textboxes

            Label commentDescriptionLabel = (Label)item.FindControl("commentDescriptionLabel");
            TextBox editCommentDescriptionTextBox = (TextBox)item.FindControl("editCommentDescriptionTextBox");
            FileUpload editCommentImageFileUpload = (FileUpload)item.FindControl("editCommentImageFileUpload");
            Button saveCommentButton = (Button)item.FindControl("saveCommentButton");
            RequiredFieldValidator validationEditCommentDescription = (RequiredFieldValidator)item.FindControl("validationEditCommentDescription");


            if (commentDescriptionLabel != null && editCommentDescriptionTextBox != null &&
            editCommentImageFileUpload != null && saveCommentButton != null && validationEditCommentDescription != null)
            {
                commentDescriptionLabel.Visible = true;
                editCommentDescriptionTextBox.Visible = true;
                editCommentImageFileUpload.Visible = true;
                saveCommentButton.Visible = true;
                validationEditCommentDescription.Visible = true;               
            }
            else
            {                
                Debug.WriteLine("One or more controls were not found.");
            }
        }

        protected void saveCommentButton_Click(object sender, EventArgs e)
        {
            Button saveButton = (Button)sender;
            int commentNo = int.Parse(saveButton.CommandArgument);
            int forumNo;
            int.TryParse(Request.QueryString["forumNo"], out forumNo);

            // Find the Repeater Item
            RepeaterItem item = (RepeaterItem)saveButton.NamingContainer;

            TextBox editCommentDescriptionTextBox = (TextBox)item.FindControl("editCommentDescriptionTextBox");
            FileUpload editCommentImageFileUpload = (FileUpload)item.FindControl("editCommentImageFileUpload");

            // Check if page is valid
            if (Page.IsValid)
            {
                string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
                using (SqlConnection connect = new SqlConnection(connString))
                {
                    string query = "UPDATE commentTable SET commentDescription = @commentDescription, commentImage = @commentImage WHERE commentNo = @commentNo";
                    SqlCommand cmd = new SqlCommand(query, connect);

                    cmd.Parameters.AddWithValue("@commentDescription", editCommentDescriptionTextBox.Text);
                    cmd.Parameters.AddWithValue("@commentNo", commentNo);

                    // Handle Image Upload
                    string imgPath = null;
                    if (editCommentImageFileUpload.HasFile)
                    {
                        string folderPath = Server.MapPath("~/commentImages/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }
                        imgPath = "~/commentImages/" + editCommentImageFileUpload.FileName;
                        editCommentImageFileUpload.SaveAs(folderPath + editCommentImageFileUpload.FileName);
                    }
                    if (imgPath != null)
                    {
                        cmd.Parameters.AddWithValue("@commentImage", imgPath);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@commentImage", DBNull.Value);
                    }

                    connect.Open();
                    cmd.ExecuteNonQuery();
                }
                // Rebind the data to reflect changes
                bindDatabase(forumNo);
            }

        }


        protected void deleteComment_Click(object sender, EventArgs e)
        {
            Button btnRemove = (Button)sender;
            string commentNoString = btnRemove.CommandArgument;
            int commentNo;
            int forumNo;
            int.TryParse(Request.QueryString["forumNo"], out forumNo);
            Debug.WriteLine("Attempting to parse commentNo: " + commentNoString);

            if (int.TryParse(commentNoString, out commentNo))
            {
                Debug.WriteLine("Successfully parsed commentNo: " + commentNo);
                string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
                using (SqlConnection connect = new SqlConnection(connString))
                {
                    string query = "DELETE FROM commentTable WHERE commentNo = @commentNo";
                    SqlCommand cmd = new SqlCommand(query, connect);
                    cmd.Parameters.AddWithValue("@commentNo", commentNo);

                    try
                    {
                        connect.Open();
                        cmd.ExecuteNonQuery();
                        Debug.WriteLine("Successfully deleted commentNo: " + commentNo);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error deleting commentNo: " + commentNo + " - " + ex.Message);
                    }
                }


                bindDatabase(forumNo);
            }
            else
            {
                Debug.WriteLine("Failed to parse commentNo: " + commentNoString);
            }
        }

        private void bindDatabase(int forumNo)
        {
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = "SELECT commentNo, commentDescription, commentImage, commentDate, forumNo, userName FROM commentTable WHERE forumNo = @forumNo";
                SqlDataAdapter da = new SqlDataAdapter(query, connect);
                da.SelectCommand.Parameters.AddWithValue("@forumNo", forumNo);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt != null && dt.Rows.Count > 0)
                {
                    rptComments.DataSource = dt;
                    rptComments.DataBind();
                }
                else
                {
                    // Add an empty row to the GridView to ensure it displays
                    dt.Rows.Add(dt.NewRow());
                    rptComments.DataSource = dt;
                    rptComments.DataBind();
                }
            }
        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            int forumNo;
            int.TryParse(Request.QueryString["forumNo"], out forumNo);
            try
            {
                string searchQuery = searchTextBox.Text.Trim();
                // Construct the SQL query to search for administrators based on the search query
                string query = @"SELECT commentNo, commentDescription, commentImage, commentDate,forumNo, userName FROM commentTable 
                                 WHERE (commentDescription LIKE '%' + @SearchQuery + '%' 
                                    OR userName LIKE '%' + @SearchQuery + '%')
                                 AND forumNo = @ForumNo";

                // Create a SqlConnection and SqlCommand
                using (SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString))
                {
                    connect.Open();
                    SqlCommand cmd = new SqlCommand(query, connect);
                    cmd.Parameters.AddWithValue("@SearchQuery", searchQuery);
                    cmd.Parameters.AddWithValue("@ForumNo", forumNo);

                    // Execute the query and fill the result into a DataTable
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Check if the DataTable is empty
                    if (dt.Rows.Count == 0)
                    {
                        rptComments.Visible = false;
                        noResultsLabel.Visible = true;
                        noResultsLabel.Text = "No results found.";
                    }
                    else
                    {
                        rptComments.Visible = true;
                        rptComments.DataSource = dt;
                        rptComments.DataBind();
                        noResultsLabel.Visible = false;
                    }

                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions and display an error message
                errorLabel.Visible = true;
                errorLabel.Text = "Error performing search: " + ex.Message;
            }
        }


        protected void rptComments_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            
        }      


    }
}
