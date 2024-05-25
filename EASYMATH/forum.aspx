<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forum.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.forum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forum</title>
    <link href="../CSS/forumCss.css" rel="stylesheet" />
    <link href="../CSS/teacherStyleSheet.css" rel="stylesheet" />
    <style>
        /* Add your CSS styles here */
        .subforum-row { border: 1px solid #ccc; margin-bottom: 10px; padding: 10px; border-radius: 5px; }
        .subforum-column { display: inline-block; vertical-align: top; }
        .center { text-align: center; }      


    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
             <img src="../IMAGES/easymathlogo.png" alt="Easy Math Logo" class="logo" />
            <h1 style="color: black;">Teacher Dashboard</h1>
        </header>
        <nav class="menu">
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="../EASYMATH/forum.aspx">Forum</a></li>
                <li><a href="#">Assignment</a></li>
                <li><a href="#">Quiz</a></li>
                <li><a href="#">Profile</a></li>                
            </ul>
        </nav>
        <section class="container">
            <div class="subforum">
                <div class="subforum-title">
                    <h1>Forum</h1>
                    <h3>
                        <asp:LinkButton ID="linkButtonCreateForum" runat="server" CssClass="aspLinkButton" OnClick="linkButtonCreateForum_Click">Create Forum</asp:LinkButton>
                    </h3>
                </div>
                <div class="search-container">
                    <asp:TextBox ID="searchTextBox" runat="server" CssClass="searchBox" Placeholder="Search forums..."></asp:TextBox>
                    <asp:Button ID="searchButton" runat="server" Text="Search Forum" OnClick="searchButton_Click" CssClass="aspButton" />
                </div>
                <asp:Label ID="noResultsLabel" runat="server" CssClass="noResultsLabel" Visible="false"></asp:Label>
                <asp:Repeater ID="rptForums" runat="server" OnItemCommand="rptForums_ItemCommand" OnItemDataBound="rptForums_ItemDataBound">
                    <ItemTemplate>
                        <div class="subforum-row">
                            <div class="subforum-description subforum-column">
                                <asp:LinkButton ID="linkButtonForumTitle" runat="server" CssClass="aspLinkButton" Text='<%# Eval("forumTitle") %>' CommandArgument='<%# Eval("forumNo") %>' OnClick="linkButtonForumTitle_Click" />
                                <br />
                                <p>Posted by: <span class="post-info"><%# Eval("UserName") %> on <%# Eval("ForumDate", "{0:dd MMM yyyy hh:mm tt}") %></span></p>  

                            </div>
                            <div class="subforum-icon subforum-column">
                                <br />
                                <br />
                                <br />
                                <asp:Label ID="img" runat="server" Text='<%# Eval("forumImage") %>' Visible="false"  ></asp:Label>
                                <asp:Image ID="forumImage" runat="server" Height="205px" Width="205px" ImageUrl='<%# Eval("forumImage") %>' Visible='<%# !string.IsNullOrEmpty(Eval("forumImage").ToString()) %>' CssClass="comment-image" />
                                <br />
                                <asp:Label ID = "forumDescriptionLabel" runat="server" Text = '<%# Eval("forumDescription") %>' />
                            </div>
                            <div class="button-column">
                                <asp:Button ID="btnViewComments" runat="server" CssClass="aspButton" Text="View Comments" CommandArgument='<%# Eval("forumNo") %>' OnClick="viewCommentsButton_Click" />
                                <asp:Button ID="editForumButton" runat="server" CssClass="aspButton" Text="Edit Forum" CommandArgument='<%# Eval("forumNo") %>' OnClick="editForumButton_Click" />
                                <asp:Button ID="deleteForumButton" runat="server" CssClass="aspButton" Text="Delete Forum" CommandArgument='<%# Eval("forumNo") %>' OnClick="deleteForumButton_Click"  OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                                <div>
                                    <asp:TextBox ID="editForumDescriptionTextBox" runat="server"  Text='<%# Eval("forumDescription") %>' Visible="false"></asp:TextBox>
                                    <asp:FileUpload ID="editForumImageFileUpload" runat="server" Visible="false" />
                                    <asp:Button ID="saveForumButton" runat="server" CssClass="aspButton" Text="Save" CommandArgument='<%# Eval("forumNo") %>' OnClick="saveForumButton_Click" Visible="false" />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="errorLabel" runat="server" Visible="false" CssClass="errorLabel"></asp:Label>
            </div>
        </section>
        <footer>
            <p>&copy; 2024 Easy Math. All rights reserved.</p>
        </footer>
    </form>
</body>
</html>
