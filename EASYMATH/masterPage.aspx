<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="masterPage.aspx.cs" Inherits="wappAssWebLearning.masterPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Master Page</title>
    <link rel="stylesheet" href="../CSS/register.css" />
    <script src="../js/jsRedirectLogin.js"></script>
    <style>
        .masterContent {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center; /* Center vertically */
            height: 100vh; /* Ensure the container takes up the full height of the viewport */
            background-image: url('../IMAGES/masterPageBackgroundKidFriends.jpg'); /* Set background image */
            background-size: cover; /* Cover the entire container */
            background-position: center; /* Center the background image */
            color: white; /* Set text color to white for better visibility */
        }
        .mybutton {
            display: flex;
            justify-content: space-around;
            align-items: center;
            overflow: hidden;
            padding: 1em 0em 1em 1em;
            background-color: yellow;
            cursor: pointer;
            box-shadow: 4px 6px 0px black;
            border: 4px solid;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
            z-index: 100;
            transition: box-shadow 250ms, transform 250ms, filter 50ms;
        }

            .mybutton:hover {
                transform: translate(2px, 2px);
                box-shadow: 2px 3px 0px black;
            }

            .mybutton:active {
                filter: saturate(0.75);
            }

            .mybutton::after {
                content: "";
                position: absolute;
                inset: 0;
                background-color: pink;
                z-index: -1;
                transform: translateX(-100%);
                transition: transform 250ms;
            }

            .mybutton:hover::after {
                transform: translateX(0);
            }

        p {
            margin-bottom: 100px;
            align-items: center;
        }
        h1{
            margin-bottom: 20px;
            align-items: center;
        }
        .content-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center;
            color: white; /* Text color for heading and paragraph */
        }
        .content-overlay h1,
        .content-overlay p {
            margin: 0;
            align-items: center;
            text-align: center;
            padding: 20px; /* Add padding for better readability */
        }
    </style>
    <script>
        function buttonMouseOver(button) {
            button.classList.add('hover-animation'); // Add CSS class for hover animation
        }

        function buttonMouseOut(button) {
            button.classList.remove('hover-animation'); // Remove CSS class for hover animation
        }

        function buttonMouseDown(button) {
            button.classList.add('active-animation'); // Add CSS class for active animation
            __doPostBack(button.name, ''); // Trigger server-side click event
        }
    </script>
    
</head>
<body class="body">
    <form id="form1" runat="server">
        <div class="header-container">
            <div>
                <a href="masterPage.aspx">
                    <img src="../IMAGES/easyMathLogo.png" alt="XXXX Image" style="width: 200px;" /></a>&nbsp;&nbsp;&nbsp;&nbsp;
            </div>
            <nav class="sub-header">
                <a href="../EASYMATH/masterPage.aspx">Home</a>
                <a href="../EASYMATH/Assignment.aspx">Assignment</a>
                <a href="../EASYMATH/Assignment.aspx">Assignment</a>
                <a href="../EASYMATH/Timetable.aspx">Timetable</a>
                <a href="../EASYMATH/Forum.aspx">Forum</a>
                <a href="../EASYMATH/About_Us.aspx">About Us</a>
                <a href="../EASYMATH/Contact_Us.aspx">Contact Us</a>
            </nav>
            <nav class="login">
                <a href="../EASYMATH/login.aspx">Login</a>
            </nav>
        </div>
        <div class="masterContent">
            <div class="content-overlay">
                <h1>Welcome to EasyMath! </h1>
                <p>Get ready for an awesome math journey with EasyMath! Learning math has never been this fun. Explore exciting games, engaging tutorials, and challenging assignments to master math skills while having a blast!</p>              
                <asp:Button ID="Button1" CssClass="auto-style1 mybutton" runat="server" Text="Start Learning" OnClick="Button1_Click" />

            </div>
        </div>

    </form>
    <footer class="footer">
        <div class="footer-container">
            <h2>Find Us More In:</h2>
            <div>
                <a href="https://www.facebook.com">
                    <img src="../IMAGES/facebookLogo.png" alt="Facebook" style="width:60px" />
                    <a />
                <a href="https://www.instagram.com">
                    <img src="../IMAGES/instagramLogo.png" alt="Instagram" style="width:100px" />
                </a>
            </div>
            <h3>&copy; <%= DateTime.Now.Year %>XXXX Website. All Rights Reserved.</h3>
        </div>
    </footer>
</body>
</html>
