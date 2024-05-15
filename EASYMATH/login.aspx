<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="webAssignment.EASYMATH.login" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../CSS/login.css" />
    <title>Login</title>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="header-container">
            <div>
                <a href="home.aspx">
                     <img src="../IMAGES/easyMathLogo.png" alt="Easy Math Image" style="width: 200px;" />
                </a>
            </div>
            <nav class="sub-header">
                <a href="../EASYMATH/home.aspx">Home</a>
                <a href="../EASYMATH/aboutUs.aspx">About Us</a>
                <a href="../EASYMATH/contactUs.aspx">Contact Us</a>
                <a href="../EASYMATH/quiz.aspx">Quiz</a>
                <a href="../EASYMATH/assignment.aspx">Assignment</a>
                <a href="../EASYMATH/register.aspx">Register</a>
            </nav>
            <nav class="login">
                <a href="../EASYMATH/login.aspx">Login</a>
            </nav>
        </div>
        <div class="login-container">
            <h2>Login here</h2>
            <h4>Stay connected with us!</h4>
            <div>
                <asp:Label ID="lblUsername" runat="server" AssociatedControlID="txtUsername" Text="Username:"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="ST001/TE001/AD001" CssClass="input"></asp:TextBox>&nbsp;
                <asp:Label ID="UsernameError" runat="server" BorderStyle="Outset" Text="UsernameError" Visible="False"></asp:Label>
                 <asp:Label ID="UsernameError1" runat="server" BorderStyle="Outset" Text="UsernameError1" Visible="False"></asp:Label>
            </div><br/>
            <div>
                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Zeke5hin@123" CssClass="input"></asp:TextBox>
                <asp:Label ID="PasswordError" runat="server" BorderStyle="Outset" Text="PasswordError" Visible="False"></asp:Label>
            </div><br/>
            <div>
                <asp:Label ID="UsernameAPasswordError" runat="server" BorderStyle="Outset" Text="UsernameAPasswordError" Visible="False"></asp:Label>
            </div>
            <br />
            <div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="button" OnClick="btnLogin_Click" ValidationGroup="loginValidation"/>
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClientClick="this.form.reset(); return false;"/>
            </div>
              <p style="font-weight: bold;">Forgot your username or password? Click here below to reset your credentials!</p>
                 <asp:Button ID="btnResetCredentials" runat="server" Text="Reset Credentials" CssClass="button" OnClick="btnResetCredentials_Click"/>
            <div>
                 <asp:Label ID="LoginError" runat="server" BorderStyle="Outset" Text="LoginError" Visible="False"></asp:Label>
            </div>
        </div>
    </form>
    <footer class="footer">
        <div class="footer-container">
            <h2>Find Us More In:</h2>
            <div>
                <a href="https://www.facebook.com">
                    <img src="../IMAGES/facebookLogo.png" alt="Facebook" style="width:60px" /></a>
                <a href="https://www.instagram.com">
                    <img src="../IMAGES/instagramLogo.png" alt="Instagram" style="width:100px" />
                </a>
            </div>
            <h3>&copy; <%= DateTime.Now.Year %> Easy Math Website. All Rights Reserved.</h3>
        </div>
    </footer>
</body>
</html>

