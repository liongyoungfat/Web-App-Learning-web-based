<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="webAssignment.EASYMATH.register" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register</title>
    <link rel="stylesheet" href="../CSS/register.css" />
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
        <div class="register-container">
            <h2>Register Here</h2>    
            <h4>Welcome to our community! Please feel free to fill up the requirements and leave no blanks.</h4>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblFirstName" runat="server" AssociatedControlID="txtFirstName" Text="First Name:" />
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="Khok" Required="true" />
                </div>
                <div class="col">
                    <asp:Label ID="lblLastName" runat="server" AssociatedControlID="txtLastName" Text="Last Name:" />
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Meng" Required="true" />
                </div>
            </div>
            <div class="row">
            <p>Gender:</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <div class="gender-container"> <!-- Wrap gender labels and radio buttons in a div -->
                    <asp:RadioButton ID="rbtnMale" runat="server" Text="Male" GroupName="gender"  />
                    <asp:RadioButton ID="rbtnFemale" runat="server" Text="Female" GroupName="gender"  />
              </div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <div class="col2">
                    <asp:Label ID="lblBirthday" runat="server" AssociatedControlID="txtBirthday" Text="Birthday:" />
                    <asp:TextBox ID="txtBirthday" runat="server" TextMode="Date" Required="true"  />
              </div>
           </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblUsername" runat="server" AssociatedControlID="txtUsername" Text="Username:" />
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="KhongMeng1" Required="true" />
                </div>
                <div class="col">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email:" />
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="KhongMeng101@gmail.com" Required="true" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblPhoneNumber" runat="server" AssociatedControlID="txtPhoneNumber" Text="Phone Number:" />
                    <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="1234567890" Required="true"  />
                </div>
                <div class="col">
                    <asp:Label ID="LlblCountry" runat="server" AssociatedControlID="txtCountry" Text="Country:" />
                    <asp:TextBox ID="txtCountry" runat="server" placeholder="Malaysia" Required="true" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblCity" runat="server" AssociatedControlID="txtCity" Text="City:" />
                    <asp:TextBox ID="txtCity" runat="server" placeholder="Kuala Lumpur" Required="true" />
                </div>
                <div class="col">
                    <asp:Label ID="lblState" runat="server" AssociatedControlID="txtState" Text="State:" />
                    <asp:TextBox ID="txtState" runat="server" placeholder="Selangor" Required="true" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblAddress" runat="server" AssociatedControlID="txtAddress" Text="Address:" />
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="1, Jalan Tun Razak" Required="true" />
                </div>
                <div class="col">
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password:" />
                    <asp:TextBox ID="txtPassword" runat="server" placeholder="Kh0ngM5ng@1" Required="true" />
                </div>
            </div>
			<br/>
             <div class="button-container">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="button" OnClick="btnRegister_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClick="btnReset_Click" />
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