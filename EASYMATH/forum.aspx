<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forum.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.forum" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forum</title>
    <link href="../CSS/forumCss.css" rel="stylesheet" />
    <style>
        .subforum-row { border: 1px solid #ccc; margin-bottom: 10px; padding: 10px; border-radius: 5px; }
        .subforum-column { display: inline-block; vertical-align: top; }
        .center { text-align: center; } 
    </style>
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
        <section class="container">
            <div class="subforum">
                <div class="subforum-title">
                    <h1>Forum</h1>
                    <div class="subforum-header">
                        <asp:LinkButton ID="linkButtonCreateForum" runat="server" CssClass="aspLinkButton" OnClick="linkButtonCreateForum_Click">Create Forum</asp:LinkButton>
                        <div class="search-container">
                            <asp:TextBox ID="searchTextBox" runat="server" CssClass="searchBox" Placeholder="Search forums..."></asp:TextBox>
                            <asp:Button ID="searchButton" runat="server" Text="Search Forum" OnClick="searchButton_Click" CssClass="aspButton" />
                        </div>
                    </div>
                </div>
                <asp:Label ID="noResultsLabel" runat="server" CssClass="noResultsLabel" Visible="false"></asp:Label>
                <asp:Repeater ID="rptForums" runat="server" OnItemDataBound="rptForums_ItemDataBound">
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
    </form>
    <footer class="footer">
    <div class="footer-container">
        <div class="footer-section contact-info">
            <h3>Contact Us</h3>
            <p>Phone: +(60)12-345678</p>
            <p>Email: info@easymath.com</p>
            <p>Address: 123 Easy Math St, Maths City, EduLand</p>
        </div>
        <div class="footer-section quick-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="~/EASYMATH/register.aspx">Register</a></li>
                <li><a href="~/EASYMATH/login.aspx">Login</a></li>
                <li><a href="~/EASYMATH/masterPage.aspx">Home</a></li>
            </ul>
        </div>
        <div class="footer-section social-media">
            <h3>Find Us More In:</h3>
            <a href="https://www.facebook.com">
                <img src="../IMAGES/facebookLogo.png" alt="Facebook" style="width:60px" /></a>
            <a href="https://www.instagram.com">
                <img src="../IMAGES/instagramLogo.png" alt="Instagram" style="width:100px" /></a>
            <a href="https://www.whatsapp.com">
            <img src="../IMAGES/whatsappLogo.png" alt="WhatsApp" style="width:52px" />
            </a>
        </div>
        <div class="footer-section recent-posts">
            <h3>Recent Blog Posts</h3>
            <ul>
                <li><a href="https://home.oxfordowl.co.uk/maths/primary-maths-age-5-6-year-1/">Understanding Math Basics</a></li>
                <li><a href="https://theparentswebsite.com.au/tag/parenting/?gad_source=1&gclid=Cj0KCQjw0ruyBhDuARIsANSZ3wrGmFICuVG9jRO3Tp1gRp71pbPMOqL7BLbcVA5rrsE06cqBMVsblWgaAlnEEALw_wcB">Tips for Effective Studying</a></li>
                <li><a href="https://www.superprof.com.my/blog/learn-maths-for-kids/">The Importance of Practice</a></li>
            </ul>
        </div>
        <div class="footer-section company-info">
            <h3>&copy; <%= DateTime.Now.Year %> Easy Math Website. All Rights Reserved.</h3>
        </div>
    </div>
</footer>
</body>
</html>
