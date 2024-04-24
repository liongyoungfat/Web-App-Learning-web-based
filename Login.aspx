<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Web_Development_Prototype.EASY_MATH_WEBPAGE.Login" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../CSS/Login.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <title>Login</title>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="header-container">
            <div>
                <a href="Home.aspx">
                    <img src="../IMAGES/easy-math-logo.png" alt="XXXX Image" style="width: 200px;" /></a>&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <nav class="sub-header">
                <a href="../EASY_MATH_WEBPAGE/Home.aspx">Home</a>
                <a href="../EASY_MATH_WEBPAGE/Assignment.aspx">Assignment</a>
                <a href="../EASY_MATH_WEBPAGE/Timetable.aspx">Timetable</a>
                <a href="../EASY_MATH_WEBPAGE/Forum.aspx">Forum</a>
                <a href="../EASY_MATH_WEBPAGE/About_Us.aspx">About Us</a>
                <a href="../EASY_MATH_WEBPAGE/Contact_Us.aspx">Contact Us</a>
            </nav>
            <nav class="login">
                <a href="../EASY_MATH_WEBPAGE/Login.aspx">Login</a>
            </nav>
        </div>
        <div class="login-container">
            <h2>Login here</h2>
            <h4>Stay connected with us!</h4>
            <div>
                <asp:Label ID="lblUsername" runat="server" AssociatedControlID="txtUsername" Text="Username:"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="ST001/LC001/AD001" CssClass="input"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." ForeColor="Red" EnableClientScript="False" ValidationGroup="Login_Validation"></asp:RequiredFieldValidator>
            </div><br/>
            <div>
                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Zeke5hin@123" CssClass="input"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." ForeColor="Red" EnableClientScript="False" ValidationGroup="Login_Validation"></asp:RequiredFieldValidator>
            </div><br/>
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="button" OnClick="btnLogin_Click" ValidationGroup="Login_Validation"/>
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClientClick="this.form.reset(); return false;"/>
            </div>
              <p style="font-weight: bold;">Forgot your username or password? Click here below to reset your credentials!</p>
                 <asp:Hyperlink ID="Hyperlink1" runat="server" NavigateUrl="~/EASY_MATH_WEBPAGE/Reset_Credentials.aspx">
                 <asp:Button ID="btnResetCredentials" runat="server" Text="Reset Credentials" CssClass="button"/>
                 </asp:HyperLink>
        </div>
    </form>
    <footer class="footer">
        <div class="footer-container">
            <h2>Find Us More In:</h2>
            <div>
                <a href="https://www.facebook.com">
                    <img src="../IMAGES/facebook-logo.png" alt="Facebook" style="width:60px" /></a>
                <a href="https://www.instagram.com">
                    <img src="../IMAGES/instagram-logo.png" alt="Instagram" style="width:100px" />
                </a>
            </div>
            <h3>&copy; <%= DateTime.Now.Year %> XXXX Website. All Rights Reserved.</h3>
        </div>
    </footer>
</body>
</html>
