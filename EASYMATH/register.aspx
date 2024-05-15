<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="webAssignment.EASYMATH.register" %>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register</title>
    <link rel="stylesheet" href="../CSS/register.css" />
     <script>
		 function checkPassword(password) {
			checkPasswordStrength(password);
			checkPasswordMatch();
		 }

		 function togglePasswordVisibility() {
			var passwordTextBox = document.getElementById('<%= txtPassword.ClientID %>');
		    var confirmPasswordTextBox = document.getElementById('<%= txtConfirmPassword.ClientID %>');
		    var passwordCheckBox = document.getElementById('<%= chkShowPassword.ClientID %>');
		    var confirmPasswordCheckBox = document.getElementById('<%= chkShowConfirmPassword.ClientID %>');

            // Check for checkbox's type 
            if (passwordCheckBox.checked) {
                passwordTextBox.type = "text";
            } else {
                passwordTextBox.type = "password";
            }   

            if (confirmPasswordCheckBox.checked) {
                confirmPasswordTextBox.type = "text";
            } else {
                confirmPasswordTextBox.type = "password";
            }
         }

         function checkPasswordStrength(password) {
            var lblPasswordStrengthResult = document.getElementById('lblPasswordStrengthResult');
            var strength = 0;

            // Check for lowercase letters
            if (password.match(/[a-z]/)) {
                strength++;
            }

            // Check for uppercase letters
            if (password.match(/[A-Z]/)) {
                strength++;
            }

            // Check for digits
            if (password.match(/[0-9]/)) {
                strength++;
            }

            // Check for special characters
            if (password.match(/[!@#$%^&*(),.?":{}|<>]/)) {
                strength++;
            }

            // Check for length
            if (password.length >= 8 && password.length <= 20) {
                strength++;
            }

            // Determine strength level and display result
            if (strength <= 2) {
                lblPasswordStrengthResult.textContent = "Weak";
                lblPasswordStrengthResult.style.color = "red";
            } else if (strength <= 3) {
                lblPasswordStrengthResult.textContent = "Medium";
                lblPasswordStrengthResult.style.color = "orange";
            } else {
                lblPasswordStrengthResult.textContent = "Strong";
                lblPasswordStrengthResult.style.color = "green";
            }

            // Check for more than 20 length password and display error message
            if (password.length >= 20) {
                lblPasswordStrengthResult.textContent = "Invalid Amount of Password";
                lblPasswordStrengthResult.style.color = "red";
            }
         }

         function checkPasswordMatch() {
            var password = document.getElementById('<%= txtPassword.ClientID %>').value;
            var confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
            var lblPasswordMatch = document.getElementById('<%= lblPasswordMatch.ClientID %>');

             // Check for password match or not
			 if (password == confirmPassword) {
				 lblPasswordMatch.textContent = "Passwords match";
				 lblPasswordMatch.style.color = "green";
             } else{
				 lblPasswordMatch.textContent = "Passwords do not match";
				 lblPasswordMatch.style.color = "red";
			 }
		 }
	 </script>
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
                <a href="../EASYMATH/forum.aspx">Forum</a>
                <a href="../EASYMATH/register.aspx">Register</a>
            </nav>
            <nav class="login">
                <a href="../EASYMATH/login.aspx">Login</a>
            </nav>
        </div>
        <div class="register-container">
            <h2>Register Here</h2>    
            <h4>Welcome to our community! Please feel free to fill up the fields with asterisk *.</h4>
            <h4 style="color: red">Please be reminded that you are required to remember the given <span class="bold-text">Username</span> and your <span class="bold-text">Password</span> for login purpose.</h4>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblFirstName" runat="server" AssociatedControlID="txtFirstName" Text="First Name: *" />
                    <asp:TextBox ID="txtFirstName" runat="server" placeholder="Khok" /><br />
                    <asp:Label ID="FirstNameError" runat="server" BorderStyle="Outset" Text="FirstNameError" Visible="False"></asp:Label>
                </div>
                <div class="col">
                    <asp:Label ID="lblLastName" runat="server" AssociatedControlID="txtLastName" Text="Last Name: *" />
                    <asp:TextBox ID="txtLastName" runat="server" placeholder="Meng"  /><br />
                    <asp:Label ID="LastNameError" runat="server" BorderStyle="Outset" Text="LastNameError" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="row">
              <div class="col"> 
                    <asp:Label ID="lblGender" runat="server" AssociatedControlID="rbtnMale" Text="Gender: *" />
                    <asp:RadioButton ID="rbtnMale" runat="server" Text="Male" GroupName="gender"  />
                    <asp:RadioButton ID="rbtnFemale" runat="server" Text="Female" GroupName="gender"  />
                    <asp:Label ID="GenderError" runat="server" BorderStyle="Outset" Text="GenderError" Visible="False" ></asp:Label>
              </div>
              <div class="col">
                    <asp:Label ID="lblBirthday" runat="server" AssociatedControlID="txtBirthday" Text="Birthday: *" />
                    <asp:TextBox ID="txtBirthday" runat="server" TextMode="Date"  /><br />
                    <asp:Label ID="BirthdayError" runat="server" BorderStyle="Outset" Text="BirthdayError" Visible="False"></asp:Label>
              </div>
           </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblUsername" runat="server" AssociatedControlID="txtUsername" Text="Username:" />
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="KhongMeng1"  /><br />
                </div>
                <div class="col">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email: *" />
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="KhongMeng101@gmail.com"  /><br />
                    <asp:RegularExpressionValidator ID="regexValidatorEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+" ForeColor="Red" EnableClientScript="False" />
                    <asp:Label ID="EmailError" runat="server" BorderStyle="Outset" Text="EmailError" Visible="False"></asp:Label>
                    <asp:Label ID="EmailError1" runat="server" BorderStyle="Outset" Text="EmailError1" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblPhoneNumber" runat="server" AssociatedControlID="txtPhoneNumber" Text="Phone Number: *" />
                    <asp:TextBox ID="txtPhoneNumber" runat="server" placeholder="013-4567890"  /><br />
                    <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Invalid phone number format" ValidationExpression="\b(019|011|012|013|014|015|016|017|018)\d-\d{7}\b" ForeColor="Red" EnableClientScript="False" />
                    <asp:Label ID="PhoneNumberError" runat="server" BorderStyle="Outset" Text="PhoneNumberError" Visible="False"></asp:Label>
                    <asp:Label ID="PhoneNumberError1" runat="server" BorderStyle="Outset" Text="PhoneNumberError1" Visible="False"></asp:Label>
                </div>
                <div class="col">
                    <asp:Label ID="LlblReligion" runat="server" AssociatedControlID="txtReligion" Text="Religion: *" />
                    <asp:TextBox ID="txtReligion" runat="server" placeholder="Buddhist"  /><br />
                    <asp:Label ID="ReligionError" runat="server" BorderStyle="Outset" Text="ReligionError" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblCity" runat="server" AssociatedControlID="txtCity" Text="City: *" />
                    <asp:TextBox ID="txtCity" runat="server" placeholder="Kuala Lumpur"  /><br />
                    <asp:Label ID="CityError" runat="server" BorderStyle="Outset" Text="CityError" Visible="False"></asp:Label>
                </div>
                <div class="col">
                    <asp:Label ID="lblState" runat="server" AssociatedControlID="txtState" Text="State: *" />
                    <asp:TextBox ID="txtState" runat="server" placeholder="Selangor" /><br />
                    <asp:Label ID="StateError" runat="server" BorderStyle="Outset" Text="StateError" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col">
                     <asp:Label ID="lblCountry" runat="server" AssociatedControlID="txtCountry" Text="Country: *" />
                     <asp:TextBox ID="txtCountry" runat="server" placeholder="Malaysia"  /><br />
                     <asp:Label ID="CountryError" runat="server" BorderStyle="Outset" Text="CountryError" Visible="False"></asp:Label>
                </div>
                <div class="col">
                    <asp:Label ID="lblAddress" runat="server" AssociatedControlID="txtAddress" Text="Address: *" />
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="1, Jalan Tun Razak"  /><br />
                   <asp:Label ID="AddressError" runat="server" BorderStyle="Outset" Text="AddressError" Visible="False"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password: *" />
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Kh0ngM5ng@1" oninput="checkPassword(this.value)" onpaste="false"/>
                    <asp:CheckBox ID="chkShowPassword" runat="server" Onclick="togglePasswordVisibility()" /> <br />
                    <asp:Label ID="PasswordError" runat="server" BorderStyle="Outset" Text="PasswordError" Visible="False"></asp:Label>
                </div>
                <div class="col">
                    <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword" Text="Confirm Password: *" />
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Kh0ngM5ng@1" oninput="checkPassword(this.value)" onpaste="false"/>
                    <asp:CheckBox ID="chkShowConfirmPassword" runat="server" Onclick="togglePasswordVisibility()" /><br />
                    <asp:Label ID="ConfirmPasswordError" runat="server" BorderStyle="Outset" Text="ConfirmPasswordError" Visible="False"></asp:Label>
                </div>
             </div>
             <div class="row">
                <div class="col">
                   <asp:Label ID ="lblPasswordStrength" runat="server" Text="Password Strength:" />
                   <asp:Label ID="lblPasswordStrengthResult" runat="server" />
                </div>
                <div class="col">
                    <asp:Label ID="lblPasswordMatch" runat="server" Text="" />
                    <asp:Label ID="PasswordError1" runat="server" BorderStyle="Outset" Text="PasswordError1" Visible="False"></asp:Label>
                </div>
            </div>
			<br/>
             <div class="button-container">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="button" OnClick="btnRegister_Click" ValidationGroup="registerValidation" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" OnClientClick="this.form.reset(); return false;" OnClick="btnReset_Click" />
            </div>
            <div>
                    <asp:Label ID="RegisterError" runat="server" BorderStyle="Outset" Text="RegisterError" Visible="False"></asp:Label>
                    <asp:Label ID="UsernameError" runat="server" BorderStyle="Outset" Text="UsernameError" Visible="False"></asp:Label>
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