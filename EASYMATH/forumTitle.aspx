<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forumTitle.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.forumTitle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forum Comments</title>
    <link href="../CSS/teacherStyleSheet.css" rel="stylesheet" />
    <link href="../CSS/commentCss.css" rel="stylesheet" />
    <style>
        /* Center the forum image */
        .image-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Flex container for buttons and search box */
        .action-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }

        .buttons-container {
            display: flex;
            gap: 10px;
        }

        .search-container {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-right: auto;
        }
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
        <div class="container">
            <div class="forum-comments">
                <h1>Forum Comments</h1>
                <h2>Forum Title： <asp:Label ID="labelForumTitle" runat="server" CssClass="forum-title" /></h2>
                <div class="image-wrapper">
                    <asp:Image ID="forumImage" runat="server" Height="205px" Width="205px" />
                </div>
                <h3>Forum Description：<asp:Label ID="labelForumDescription" runat="server" CssClass="forum-description" /></h3>
                <p>Posted by: <asp:Label ID="labelTeachUserName" runat="server" CssClass="post-info" /> On <asp:Label ID="labelForumDate" runat="server" CssClass="post-info" /></p>                
                <p>
                    <asp:TextBox ID="commentTextBox" runat="server" CssClass="searchBox" Visible="false"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="validationCommentTextBox" runat="server" ControlToValidate="commentTextBox" ErrorMessage="Comment is required." Display="Dynamic" ForeColor="Red" SetFocusOnError="True" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:FileUpload ID="commentFileUpload" runat="server" CssClass="searchBox" Visible="false" />
                </p>
                <div class="action-container">
                    <div class="buttons-container">
                        <asp:Button ID="addCommentButton" runat="server" CssClass="aspButton" Text="Add Comment" OnClick="addCommentButton_Click" />
                        <asp:Button ID="postCommentButton" runat="server" CssClass="aspButton" Text="Post Comment" OnClick="postComment_Click" Visible="false" />
                    </div>
                    <div class="search-container">
                        <asp:TextBox ID="searchTextBox" runat="server" CssClass="searchBox" Placeholder="Search forums..."></asp:TextBox>
                        <asp:Button ID="searchButton" runat="server" CssClass="aspButton" Text="Search Comment" OnClick="searchButton_Click" />
                    </div>
                </div>
                <asp:Label ID="noResultsLabel" runat="server" CssClass="noResultsLabel" Visible="false"></asp:Label>
            </div>
                <asp:Repeater ID="rptComments" runat="server" OnItemCommand="rptComments_ItemCommand">
                    <ItemTemplate>
                        <div class="subforum-row">
                            <div class="subforum-content">
                                <div class="subforum-icon subforum-column center">
                                    <p>Posted by: <span class="post-info"><%# Eval("userName") %> on <%# Eval("commentDate", "{0:dd MMM yyyy hh:mm tt}") %></span></p>  
                                </div>
                                <div class="subforum-text subforum-column">
                                    <asp:Label ID="img" runat="server" Text='<%# Eval("commentImage") %>' Visible="false"  ></asp:Label>
                                    <asp:Image ID="commentImage" runat="server" Height="205px" Width="237px" CssClass="commentImage" ImageUrl='<%# Eval("commentImage") %>' Visible='<%# !string.IsNullOrEmpty(Eval("commentImage").ToString()) %>'/>
                                    <br />
                                    <asp:Label ID = "commentDescriptionLabel" runat="server" Text = '<%# Eval("commentDescription") %>'/>
                                </div>
                            </div>
                            <div>
                                <asp:Button ID="editCommentButton" runat="server" CssClass="aspButton" Text="Edit Comment" CommandArgument='<%# Eval("commentNo") %>' OnClick="editCommentButton_Click" Visible='<%# (Eval("userName").ToString()== Session["userName"].ToString()) %>'/>
                                <asp:Button ID="deleteCommentButton" runat="server" CssClass="aspButton" Text="Delete Comment" CommandArgument='<%# Eval("commentNo") %>'  OnClick="deleteComment_Click" Visible='<%# (Eval("userName").ToString()== Session["userName"].ToString()) %>'  OnClientClick="return confirm('Are you sure you want to delete this record?');"/>
                                <asp:TextBox ID="editCommentDescriptionTextBox" runat="server" CssClass="searchBox" Text='<%# Eval("commentDescription") %>' Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="validationEditCommentDescription" runat="server" ControlToValidate="editCommentDescriptionTextBox" ErrorMessage="Comment is required." Display="Dynamic"  Visible="false" ForeColor="Red" SetFocusOnError="True" />
                                <asp:FileUpload ID="editCommentImageFileUpload" runat="server" CssClass="searchBox" Visible="false" />
                                <asp:Button ID="saveCommentButton" runat="server" CssClass="aspButton" Text="Save" CommandArgument='<%# Eval("commentNo") %>' OnClick="saveCommentButton_Click" Visible="false" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            <asp:Label ID="errorLabel" runat="server" Visible="false" CssClass="errorLabel"></asp:Label>
        </div>
    </form>
</body>
</html>
