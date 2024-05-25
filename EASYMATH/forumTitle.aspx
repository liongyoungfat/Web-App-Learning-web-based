<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forumTitle.aspx.cs" Inherits="webAssignment.EASYMATH.forumTitle" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forum Comments</title>
    <link href="../CSS/commentCss.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div class="logo-container">
                <img src="../IMAGES/easymathlogo.png" alt="Easy Math Logo" class="logo" />
            </div>
            <div class="header-text-container">
            <h1 style="color: black;">Admin Management</h1>
                <a href="login.aspx" class="sign-out-link">
                    <img src="../IMAGES/signout.png" alt="Sign Out" style="width: 30px; height: 30px;" />
                    <span>Sign Out</span>
                </a>
            </div>
        </header>
        <nav class="menu">
            <ul>
                <li><a href="home.aspx">Home</a></li>
                <li><a href="forum.aspx">Forum</a></li>
                <li><a href="assignment.aspx">Assignment</a></li>
                <li><a href="quiz.aspx">Quiz</a></li>
                <li><a href="profile.aspx">Profile</a></li>
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
                <div >
                    <div class="comment-container">
                        <asp:TextBox ID="commentTextBox" runat="server" CssClass="searchBox" Visible="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="validationCommentTextBox" runat="server" ControlToValidate="commentTextBox" ErrorMessage="Comment is required." Display="Dynamic" ForeColor="Red" SetFocusOnError="True" Visible="false" />
                        <asp:FileUpload ID="commentFileUpload" runat="server" CssClass="searchBox" Visible="false" />
                    </div>
                        <div class="buttons-container">
                            <asp:Button ID="addCommentButton" runat="server" CssClass="aspButton" Text="Add Comment" OnClick="addCommentButton_Click" />
                            <asp:Button ID="postCommentButton" runat="server" CssClass="aspButton" Text="Post Comment" OnClick="postComment_Click" Visible="false" />
                        </div>
                        <div class="search-container">
                            <asp:TextBox ID="searchTextBox" runat="server" CssClass="searchBox" Placeholder="Search Comments..."></asp:TextBox>
                            <asp:Button ID="searchButton" runat="server" CssClass="aspButton" Text="Search Comment" OnClick="searchButton_Click" />
                        </div>
                    <asp:Label ID="noResultsLabel" runat="server" CssClass="noResultsLabel" Visible="false"></asp:Label>
                </div>         
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
                            <div class="search-container">
                                <asp:Button ID="editCommentButton" runat="server" CssClass="aspButton" Text="Edit Comment" CommandArgument='<%# Eval("commentNo") %>' OnClick="editCommentButton_Click" Visible='<%# (Eval("userName").ToString()== Session["userName"].ToString()) %>'/>
                                <asp:Button ID="deleteCommentButton" runat="server" CssClass="aspButton" Text="Delete Comment" CommandArgument='<%# Eval("commentNo") %>'  OnClick="deleteComment_Click" Visible='<%# (Eval("userName").ToString()== Session["userName"].ToString()) %>'  OnClientClick="return confirm('Are you sure you want to delete this record?');"/>
                                <asp:TextBox ID="editCommentDescriptionTextBox" runat="server" CssClass="searchBox" Text='<%# Eval("commentDescription") %>' Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="validationEditCommentDescription" runat="server" ControlToValidate="editCommentDescriptionTextBox" ErrorMessage="Comment is required." Display="Dynamic"  Visible="false" ForeColor="Red" SetFocusOnError="True" />
                                <asp:FileUpload ID="editCommentImageFileUpload" runat="server" CssClass="searchBox" Visible="false" />
                                <asp:Button ID="saveCommentButton" runat="server" CssClass="aspButton" Text="Save" CommandArgument='<%# Eval("commentNo") %>' OnClick="saveCommentButton_Click" Visible="false" />
                                <asp:Button ID="cancelEditButton" runat="server" CssClass="aspButton" Text="Cancel" CommandArgument='<%# Eval("commentNo") %>' OnClick="cancelEditButton_Click" Visible="false" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            <asp:Label ID="errorLabel" runat="server" Visible="false" CssClass="errorLabel"></asp:Label>
        </div>
    </form>
    <footer class="footer">
    <div class="footer-container">
        <div class="footer-section contact-info">
             <h3 style="color:black">Contact Us</h3>
            <p>Phone: +(60)12-345678</p>
            <p>Email: info@easymath.com</p>
            <p>Address: 123 Easy Math St, Maths City, EduLand</p>
        </div>
        <div class="footer-section quick-links">
            <h3 style="color:black">Quick Links</h3>
            <ul>
                <li><a href="~/EASYMATH/register.aspx">Register</a></li>
                <li><a href="~/EASYMATH/login.aspx">Login</a></li>
                <li><a href="~/EASYMATH/masterPage.aspx">Home</a></li>
            </ul>
        </div>
        <div class="footer-section social-media">
           <h3 style="color:black">Find Us More In:</h3>
            <a href="https://www.facebook.com">
                <img src="../IMAGES/facebookLogo.png" alt="Facebook" style="width:60px" /></a>
            <a href="https://www.instagram.com">
                <img src="../IMAGES/instagramLogo.png" alt="Instagram" style="width:100px" /></a>
            <a href="https://www.whatsapp.com">
            <img src="../IMAGES/whatsappLogo.png" alt="WhatsApp" style="width:52px" />
            </a>
        </div>
        <div class="footer-section recent-posts">
            <h3 style="color:black">Recent Blog Post</h3>
            <ul>
                <li><a href="https://home.oxfordowl.co.uk/maths/primary-maths-age-5-6-year-1/">Understanding Math Basics</a></li>
                <li><a href="https://theparentswebsite.com.au/tag/parenting/?gad_source=1&gclid=Cj0KCQjw0ruyBhDuARIsANSZ3wrGmFICuVG9jRO3Tp1gRp71pbPMOqL7BLbcVA5rrsE06cqBMVsblWgaAlnEEALw_wcB">Tips for Effective Studying</a></li>
                <li><a href="https://www.superprof.com.my/blog/learn-maths-for-kids/">The Importance of Practice</a></li>
            </ul>
        </div>
        <div class="footer-section company-info">
            <h3 style="color:black">&copy; <%= DateTime.Now.Year %> Easy Math Website. All Rights Reserved.</h3>
        </div>
    </div>
</footer>
</body>
</html>
