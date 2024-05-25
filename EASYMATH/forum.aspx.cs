using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace wappAssWebLearning.EASYMATH
{
    public partial class forum : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usertype"] != null && Session["usertype"].ToString() == "TE")
            {
                linkButtonCreateForum.Visible= true;
            }
            if (!IsPostBack)
            {
                loadForums();
            }
        }

        protected void linkButtonCreateForum_Click(object sender, EventArgs e)
        {
            Response.Redirect("../EASYMATH/addForum.aspx");
        }


        private void loadForums()
        {
            List<Forum> forums = getForumsFromDatabase();
            rptForums.DataSource = forums;
            rptForums.DataBind();
        }

        public class Forum
        {
            public int forumNo { get; set; }
            public string forumTitle { get; set; }
            public string forumDescription { get; set; }
            public string forumImage { get; set; }
            public DateTime ForumDate { get; set; }
            public string UserName { get; set; }
        }

        private List<Forum> getForumsFromDatabase()
        {
            List<Forum> forums = new List<Forum>();
            string connectionString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT forumNo, forumTitle, forumDescription, forumImage, forumDate, userName FROM forumTable";
                SqlCommand cmd = new SqlCommand(query, conn);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Forum forum = new Forum
                        {
                            forumNo = (int)reader["forumNo"],
                            forumTitle = reader["forumTitle"].ToString(),
                            forumDescription = reader["forumDescription"].ToString(),
                            forumImage = reader["forumImage"].ToString(),
                            ForumDate = (DateTime)reader["forumDate"],
                            UserName = reader["userName"].ToString()
                            
                        };
                        forums.Add(forum);
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
            return forums;
        }

        protected void linkButtonForumTitle_Click(object sender, EventArgs e)
        {
            LinkButton clickedButton = (LinkButton)sender;
            string forumNo = clickedButton.CommandArgument;
            Response.Redirect($"../EASYMATH/forumTitle.aspx?forumNo={forumNo}");
        }



        protected void viewCommentsButton_Click(object sender, EventArgs e)
        {
            Button clickedButton = (Button)sender;
            string forumNo = clickedButton.CommandArgument;
            Response.Redirect($"../EASYMATH/forumTitle.aspx?forumNo={forumNo}");
        }

        protected void editForumButton_Click(object sender, EventArgs e)
        {
            Button editButton = (Button)sender;
            int forumNo = int.Parse(editButton.CommandArgument);

            // Find the Repeater Item
            RepeaterItem item = (RepeaterItem)editButton.NamingContainer;

            Label forumDescriptionLabel = (Label)item.FindControl("forumDescriptionLabel");
            TextBox editForumDescriptionTextBox = (TextBox)item.FindControl("editForumDescriptionTextBox");
            FileUpload editForumImageFileUpload = (FileUpload)item.FindControl("editForumImageFileUpload");
            Button saveForumButton = (Button)item.FindControl("saveForumButton");

            if (forumDescriptionLabel != null && editForumDescriptionTextBox != null &&
            editForumImageFileUpload != null && saveForumButton != null)
            {
                // Hide the labels and show the textboxes

                forumDescriptionLabel.Visible = true;
                editForumDescriptionTextBox.Visible = true;
                editForumImageFileUpload.Visible = true;
                saveForumButton.Visible = true;
            }
            else
            {
                // Log or handle the error
                System.Diagnostics.Debug.WriteLine("One or more controls were not found.");
            }
        }

        protected void saveForumButton_Click(object sender, EventArgs e)
        {
            Button saveButton = (Button)sender;
            int forumNo = int.Parse(saveButton.CommandArgument);

            // Find the Repeater Item
            RepeaterItem item = (RepeaterItem)saveButton.NamingContainer;

            TextBox editForumDescriptionTextBox = (TextBox)item.FindControl("editForumDescriptionTextBox");
            FileUpload editForumImageFileUpload = (FileUpload)item.FindControl("editForumImageFileUpload");

            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = "UPDATE forumTable SET forumDescription = @forumDescription, forumImage = @forumImage WHERE forumNo = @forumNo";
                SqlCommand cmd = new SqlCommand(query, connect);

                cmd.Parameters.AddWithValue("@forumDescription", editForumDescriptionTextBox.Text);
                cmd.Parameters.AddWithValue("@forumNo", forumNo);

                // Handle Image Upload
                string imgPath = null;
                if (editForumImageFileUpload.HasFile)
                {
                    string folderPath = Server.MapPath("~/forumImages/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }
                    imgPath = "~/forumImages/" + editForumImageFileUpload.FileName;
                    editForumImageFileUpload.SaveAs(folderPath + editForumImageFileUpload.FileName);
                }
                if (imgPath != null)
                {
                    cmd.Parameters.AddWithValue("@forumImage", imgPath);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@forumImage", DBNull.Value);
                    //if teacher want to make the image missing
                    //limitatation: every edit need upload same picture
                }

                connect.Open();
                cmd.ExecuteNonQuery();
            }

            // Rebind the data to reflect changes
            bindDatabase();
        }

        protected void deleteForumButton_Click(object sender, EventArgs e)
        {
            Button deleteForumButton = (Button)sender;
            string commentNoString = deleteForumButton.CommandArgument;
            int forumNo;
            int.TryParse(Request.QueryString["forumNo"], out forumNo);
            Debug.WriteLine("Attempting to parse commentNo: " + commentNoString);

            if (int.TryParse(commentNoString, out forumNo))
            {
                
                string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
                using (SqlConnection connect = new SqlConnection(connString))
                {
                    try
                    {
                        connect.Open();
                        // Since Forum No is the foreign key of the forum table, need to Delete 1st comments related to the forum
                        string deleteCommentsQuery = "DELETE FROM commentTable WHERE forumNo = @forumNo";
                        SqlCommand deleteCommentsCmd = new SqlCommand(deleteCommentsQuery, connect);
                        deleteCommentsCmd.Parameters.AddWithValue("@forumNo", forumNo);
                        deleteCommentsCmd.ExecuteNonQuery();
                        Debug.WriteLine("Successfully deleted comments for forumNo: " + forumNo);


                        // Then Delete the forum
                        string deleteForumQuery = "DELETE FROM forumTable WHERE forumNo = @forumNo";
                        SqlCommand deleteForumCmd = new SqlCommand(deleteForumQuery, connect);
                        deleteForumCmd.Parameters.AddWithValue("@forumNo", forumNo);
                        deleteForumCmd.ExecuteNonQuery();
                        
                        string script = "alert('Successfully deleted this record');"; // Use alert for simplicity
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showAlert", script, true);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error deleting commentNo: " + forumNo + " - " + ex.Message);
                    }
                }
                bindDatabase();
            }
            else
            {
                Debug.WriteLine("Failed to parse commentNo: " + commentNoString);
            }
        }

        private void bindDatabase()
        {
            string connString = ConfigurationManager.ConnectionStrings["myConn"].ConnectionString;
            using (SqlConnection connect = new SqlConnection(connString))
            {
                string query = "SELECT forumNo, forumTitle, forumDescription, forumImage, forumDate, userName FROM forumTable";
                SqlDataAdapter da = new SqlDataAdapter(query, connect);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt != null && dt.Rows.Count > 0)
                {
                    rptForums.DataSource = dt;
                    rptForums.DataBind();
                }
                else
                {
                    rptForums.DataSource = dt;
                    rptForums.DataBind();
                }
            }
        }




        protected void rptForums_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["usertype"] != null && Session["usertype"].ToString() == "TE")
            {
                // Find the controls within the current RepeaterItem
                Button editForumButton = (Button)e.Item.FindControl("editForumButton");
                Button deleteForumButton = (Button)e.Item.FindControl("deleteForumButton");

                if (editForumButton != null && deleteForumButton != null)
                {
                    editForumButton.Visible = true;
                    deleteForumButton.Visible = true;
                }
            }
        }
        protected void rptForums_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {            

                Forum forum = e.Item.DataItem as Forum; // Cast to Forum
                if (forum != null)
                {
                    Image forumImage = (Image)e.Item.FindControl("forumImage");
                    if (forumImage != null)
                    {
                        if (string.IsNullOrEmpty(forum.forumImage))
                        {
                            forumImage.Visible = false;
                            System.Diagnostics.Debug.WriteLine("forumImage is null or empty, setting Visible to false.");
                        }
                        else
                        {
                            forumImage.Visible = true;
                            forumImage.ImageUrl = ResolveUrl(forum.forumImage);
                            System.Diagnostics.Debug.WriteLine($"forumImage URL: {forum.forumImage}, setting Visible to true.");
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("forumImage control is null.");
                    }
                }

                string currentUsername = Session["userName"]?.ToString();
                string postUsername = DataBinder.Eval(e.Item.DataItem, "userName").ToString();

                if (currentUsername != null && currentUsername == postUsername && Session["usertype"].ToString() == "TE")
                {
                    Button editForumButton = (Button)e.Item.FindControl("editForumButton");
                    Button deleteForumButton = (Button)e.Item.FindControl("deleteForumButton");

                    if (editForumButton != null && deleteForumButton != null)
                    {
                        editForumButton.Visible = true;
                        deleteForumButton.Visible = true;
                    }
                }
                else
                {
                    Button editForumButton = (Button)e.Item.FindControl("editForumButton");
                    Button deleteForumButton = (Button)e.Item.FindControl("deleteForumButton");

                    if (editForumButton != null && deleteForumButton != null && Session["usertype"].ToString() == "TE")
                    {
                        editForumButton.Visible = false;
                        deleteForumButton.Visible = false;
                    }
                }

            }
        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            try
            {
                string searchQuery = searchTextBox.Text.Trim();
                // Construct the SQL query to search for administrators based on the search query
                string query = @"SELECT forumNo, forumTitle, forumDescription, forumImage, forumDate, userName FROM forumTable 
                                 WHERE forumTitle LIKE '%' + @SearchQuery + '%' 
                                 OR forumDescription LIKE '%' + @SearchQuery + '%' 
                                 OR userName LIKE '%' + @SearchQuery + '%'";

                // Create a SqlConnection and SqlCommand
                using (SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString))
                {
                    connect.Open();
                    SqlCommand cmd = new SqlCommand(query, connect);
                    cmd.Parameters.AddWithValue("@SearchQuery", searchQuery);

                    // Execute the query and fill the result into a DataTable
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Check if the DataTable is empty
                    if (dt.Rows.Count == 0)
                    {
                        rptForums.Visible = false;
                        noResultsLabel.Visible = true;
                        noResultsLabel.Text = "No results found.";
                    }
                    else
                    {
                        rptForums.Visible = true;
                        rptForums.DataSource = dt;
                        rptForums.DataBind();
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
    }
}