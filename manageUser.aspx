<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageUser.aspx.cs" Inherits="Lab06.manageUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Manage Member Profile"></asp:Label>
            <br />
            <asp:Label ID="usernameLabel" runat="server" Text="Username"></asp:Label>
            <br />
            <asp:Label ID="memberUsernameLabel" runat="server" Text="Username:"></asp:Label>
&nbsp;<asp:DropDownList ID="uname" runat="server">
            </asp:DropDownList>
            <br />
            <asp:Label ID="memberUsernameLabel0" runat="server" Text="First Name:"></asp:Label>
&nbsp;<asp:TextBox ID="fNameBox" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="memberUsernameLabel1" runat="server" Text="Last Name:"></asp:Label>
&nbsp;<asp:TextBox ID="fNameBox0" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="memberUsernameLabel5" runat="server" Text="Gender:"></asp:Label>
&nbsp;<asp:DropDownList ID="DropDownList2" runat="server">
                <asp:ListItem>M</asp:ListItem>
                <asp:ListItem>F</asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Label ID="memberUsernameLabel2" runat="server" Text="Country:"></asp:Label>
&nbsp;<asp:TextBox ID="fNameBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="memberUsernameLabel3" runat="server" Text="Email:"></asp:Label>
&nbsp;<asp:TextBox ID="fNameBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="memberUsernameLabel4" runat="server" Text="Password:"></asp:Label>
&nbsp;<asp:TextBox ID="fNameBox3" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Save" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="Remove" />
&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Text="errMsg"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:Label ID="usertypeLabel" runat="server" Text="Member"></asp:Label>
        </div>
    </form>
</body>
</html>
