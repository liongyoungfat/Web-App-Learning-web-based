<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addForum.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.addForum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../CSS/teacherStyleSheet.css" rel="stylesheet" />
    <link href="../CSS/addForum.css" rel="stylesheet" />
    <title>Add Forum</title>
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
            <h1>Adding Forum</h1>
            <div class="form-group">
                <h3>Topic:</h3>
                <asp:TextBox ID="forumTopicTextBox" runat="server" CssClass="textBox" ForeColor="Black"></asp:TextBox>
                <asp:RequiredFieldValidator ID="validationForumTopic" runat="server" ControlToValidate="forumTopicTextBox" ErrorMessage="Topic is required." Display="Dynamic" ForeColor="Red" SetFocusOnError="True" />
            </div>
            <div class="form-group">
                <h3>Content:</h3>
                <asp:TextBox ID="forumContentTextBox" runat="server" CssClass="textBox" ForeColor="Black" TextMode="MultiLine" Rows="5"></asp:TextBox>
                <asp:RequiredFieldValidator ID="validationForumContent" runat="server" ControlToValidate="forumContentTextBox" ErrorMessage="Content is required." Display="Dynamic" ForeColor="Red" SetFocusOnError="True" />
            </div>
            <div class="form-group">
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="aspButton"/>
            </div>
            <div class="form-group center">
                <asp:Button ID="postButton" runat="server" CssClass="aspButton" OnClick="postButton_Click" Text="Post" />
                <asp:Label ID="errMsg" runat="server" Text="errMsg" Visible="False" CssClass="errMsg"></asp:Label>
                <asp:Label ID="img" runat="server" Text="Label" Visible="false"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
